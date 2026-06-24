import re, urllib.request, urllib.parse, html, json

DEEPL_KEY = "ae523d75-fd93-42c3-8ff9-4c6777774df7:fx"

with open('lib/core/localization/app_localizations.dart', 'r') as f:
    content = f.read()

# Step 1: Add isHi boolean after isRu
content = content.replace(
    "  bool get isRu => locale.languageCode == 'ru';\n",
    "  bool get isRu => locale.languageCode == 'ru';\n  bool get isHi => locale.languageCode == 'hi';\n"
)

lines = content.split('\n')

# Step 2: Find all locations where we need to insert isHi
# Pattern: at the end of each getter, before the final ': 'English''
# Two patterns:
#   One-liner:  : isRu ? 'Ru' : 'En';
#   Multi-line: : isRu\n? 'Ru'\n: 'En';

# We'll find the index of the last ':' before ';' in each getter/method
# A getter ends with ';' and is preceded by ': 'text';' pattern

# Find all getters and methods
entries = []  # (start_line, end_line, eng_text, is_multiline)

i = 0
while i < len(lines):
    line = lines[i]
    # Detect start of a getter or method (String get, String getName, int get, List get, etc.)
    if re.search(r'\b(String|int|List|bool)\s+(get\s+)?\w+\s*(=>|\(.*\)\s*=>)', line):
        # This is a one-liner getter/method
        if '=>' in line and ';' in line and line.strip().endswith(';'):
            # Extract the English fallback text (last : '...' before ;)
            m = re.search(r":\s*'((?:[^'\\]|\\.)*)'\s*;\s*$", line)
            if m:
                eng_text = m.group(1).replace("\\'", "'")
                entries.append((i, i, eng_text, False))
        else:
            # Multi-line: find the closing ;
            j = i + 1
            while j < len(lines) and ';' not in lines[j]:
                j += 1
            if j < len(lines) and ';' in lines[j]:
                # Find the last ': 'text'' before ;
                # Search backwards from j
                text_line = lines[j]
                m = re.search(r":\s*'((?:[^'\\]|\\.)*)'\s*;?", text_line)
                if m:
                    eng_text = m.group(1).replace("\\'", "'")
                    entries.append((i, j, eng_text, True))
    i += 1

print(f"Found {len(entries)} getters/methods to update")

# Collect unique English texts for translation
texts_to_translate = [e[2] for e in entries]
translations = {}

# Translate via DeepL API in batches
batch_size = 10
total_batches = (len(texts_to_translate) - 1) // batch_size + 1

for i in range(0, len(texts_to_translate), batch_size):
    batch = texts_to_translate[i:i+batch_size]
    params = urllib.parse.urlencode([('target_lang', 'HI')] + [('text', t) for t in batch])
    data = params.encode('utf-8')
    headers = {
        'Authorization': f'DeepL-Auth-Key {DEEPL_KEY}',
        'Content-Type': 'application/x-www-form-urlencoded',
    }
    try:
        req = urllib.request.Request('https://api-free.deepl.com/v2/translate', data=data, headers=headers)
        resp = urllib.request.urlopen(req, timeout=60)
        result = json.loads(resp.read().decode('utf-8'))
        for orig, t in zip(batch, result['translations']):
            translations[orig] = html.unescape(t['text'])
        print(f"Batch {i//batch_size + 1}/{total_batches} OK")
    except Exception as e:
        print(f"Batch {i//batch_size + 1} failed: {e}")
        try:
            print(resp.read().decode('utf-8')[:300])
        except:
            pass
        for t in batch:
            translations[t] = t  # fallback to English

print(f"Translated {len(translations)} unique texts")

# Step 3: Apply translations in reverse order
for start, end, eng_text, is_multiline in reversed(entries):
    hi_text = translations.get(eng_text, eng_text)
    
    if is_multiline:
        # For multi-line, insert before the last ': 'English''
        text_line = lines[end]
        # Find the : '...' at the end
        m = re.search(r"(\s*)(:\s*')((?:[^'\\]|\\.)*)(')", text_line)
        if m:
            indent = m.group(1)
            # Add : isHi ? 'Hindi' \n before the English fallback
            # The new code should be:
            # : isHi
            # ? 'Hindi'
            # : 'English';
            ishi_indent = indent + '  '
            insert = f"\n{ishi_indent}: isHi\n{ishi_indent}? '{hi_text}'"
            old_line = lines[end]
            new_line = old_line[:m.start(2)] + insert + '\n' + indent + ': ' + lines[end][m.start(3)-1:]
            lines[end] = new_line
    else:
        # One-liner: insert : isHi ? 'Hindi' before the final : 'English'
        line = lines[start]
        m = re.search(r"(\s*)(:\s*')((?:[^'\\]|\\.)*)('\s*;\s*$)", line)
        if m:
            indent = m.group(1)
            insert = f" : isHi ? '{hi_text}'"
            new_line = line[:m.start(2)] + insert + '\n' + indent + ': ' + line[m.start(3)-1:]
            lines[start] = new_line
        else:
            # Try alternative pattern for one-liners
            m = re.search(r"(:\s*')((?:[^'\\]|\\.)*)('\s*;\s*$)", line)
            if m:
                insert = f" : isHi ? '{hi_text}'"
                new_line = line[:m.start(1)] + insert + '\n' + line[m.start(2)-1:]
                lines[start] = new_line

content = '\n'.join(lines)

with open('lib/core/localization/app_localizations.dart', 'w') as f:
    f.write(content)

print("Done! All Hindi translations added.")
