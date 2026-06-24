import re

with open('lib/core/localization/app_localizations.dart', 'r') as f:
    content = f.read()
lines = content.split('\n')

# Fix 1: Fix broken line 1709 (the emoji/text fragment)
# Find and fix any line that has : ' : isEs (broken text)
for i in range(len(lines)):
    if ": ' : is" in lines[i]:
        # This line is broken; the Hindi insertion went wrong here
        # The original likely had something like: : 'Best: ...'
        # Let's just note it
        print(f"Broken line {i+1}: {lines[i][:100]}...")

# Fix 2: Collapse one-liners back to single line
# Pattern: line ends with 'Ru text'\n followed by : isHi line\n followed by ? 'Hi' line\n followed by : 'En' line
# Replace with: line ends with 'Ru text' : isHi ? 'Hi' : 'En';
i = 0
fixes = []
while i < len(lines) - 3:
    l0 = lines[i]
    l1 = lines[i+1]
    l2 = lines[i+2]
    l3 = lines[i+3]
    
    # Check if l1 is : isHi, l2 is ? '..., l3 is : '...'
    if (l1.strip().startswith(': isHi') and 
        l2.strip().startswith('? ') and 
        l3.strip().startswith(': ')):
        
        # Get the text from l2
        m2 = re.search(r"\?\s*'(.+?)'", l2)
        # Get the English text from l3
        m3 = re.search(r":\s*'(.+?)'", l3)
        
        if m2 and m3:
            hi_text = m2.group(1)
            en_text = m3.group(1)
            
            # Check if l0 already has : isRu inline (one-liner case)
            # or ends with ' on its own (multi-line case)
            has_inline_ru = bool(re.search(r":\s*isRu\s*\?\s*'[^']*'\s*$", l0.rstrip()))
            
            if has_inline_ru:
                # One-liner: collapse
                indent = re.match(r'^(\s*)', l0).group(1)
                new_line = f"{indent}{l0.strip()} : isHi ? '{hi_text}' : '{en_text}';"
                # But we need to be careful about the existing ';' in l3 
                # Actually l0.strip() might already contain the isRu ? 'Ru' part
                # Let's just use the line as-is but format properly
                
                # Actually simpler approach: 
                # l0 ends with : isRu ? 'Ru'
                # We want: l0 + : isHi ? 'Hi' + \n + indent + : 'En';
                new_l0 = l0.rstrip()
                # Remove any trailing continuation if present
                fixes.append({
                    'type': 'oneliner',
                    'lines': [i, i+1, i+2, i+3],
                    'l0': l0,
                    'hi_text': hi_text.replace("\\'", "'"),
                    'en_text': en_text.replace("\\'", "'"),
                })
            else:
                # Multi-line: fix indentation
                fixes.append({
                    'type': 'multiline',
                    'lines': [i, i+1, i+2, i+3],
                    'l0': l0,
                    'l1': l1,
                    'l2': l2, 
                    'l3': l3,
                    'hi_text': hi_text.replace("\\'", "'"),
                    'en_text': en_text.replace("\\'", "'"),
                })
    i += 1

print(f"Found {len(fixes)} entries with formatting issues")

# Apply fixes in reverse order
for fix in reversed(fixes):
    if fix['type'] == 'oneliner':
        # Collapse back to one line
        i = fix['lines'][0]
        l0 = fix['l0']
        # l0 currently: ... isRu ? 'Ru' (no ;)
        # Add : isHi ? 'Hi' then newline + indent + : 'En';
        indent = re.match(r'^(\s*)', l0).group(1)
        
        # Determine the existing format: does l0 already have a partial isHi?
        # l0.strip() should be something like: isAr ? 'Ar' : isEs ? 'Es' : ... : isRu ? 'Ru'
        
        # Find the indentation and rebuild
        stripped = l0.strip()
        hi_escaped = fix['hi_text'].replace("'", "\\'")
        en_escaped = fix['en_text'].replace("'", "\\'")
        
        new_content = f"{stripped} : isHi ? '{hi_escaped}'"
        new_l3 = f"{indent}: '{en_escaped}';"
        
        # Replace lines i through i+3
        lines[i] = new_content
        lines[i+1] = new_l3
        lines[i+2] = ''
        lines[i+3] = ''
    
    elif fix['type'] == 'multiline':
        # Fix indentation to match : isRu and ? 'Ru' indent
        i = fix['lines'][0]
        l0 = fix['l0']
        l3 = fix['l3']
        
        # Scan backwards from l0 to find : isRu / ? 'Ru' indent
        # l0 should have : isRu (with its indent), 
        # and l-1 should have ? 'Ru' (with its indent)
        if i > 0:
            l_prev = lines[i-1]  # This should be ? 'Russian' or similar
            isru_indent = len(l0) - len(l0.lstrip())
            q_ru_indent = len(l_prev) - len(l_prev.lstrip()) if i > 0 else isru_indent
        
        hi_escaped = fix['hi_text'].replace("'", "\\'")
        en_escaped = fix['en_text'].replace("'", "\\'")
        
        # Fix : isHi indent
        lines[i+1] = f"{' ' * isru_indent}: isHi"
        # Fix ? 'Hi' indent
        lines[i+2] = f"{' ' * q_ru_indent}? '{hi_escaped}'"
        # Fix : 'En' to match original l3 indent
        lines[i+3] = f"{re.match(r'^(\s*)', l3).group(1)}: '{en_escaped}';"

# Remove empty lines that were created
lines = [l for l in lines if l != '']

content = '\n'.join(lines)

# Fix broken lines with fragment text
# Look for : ' : isEs or : ' : isFr patterns
content = re.sub(r": ' : isEs \? '([^']*)' : isFr \? '([^']*)' : isPt \? '([^']*)' : isRu \? '([^']*)' : '([^']*)'",
    lambda m: f": isHi ? '{{\\g<0>}}'", content)
# Actually let me handle this differently

with open('lib/core/localization/app_localizations.dart', 'w') as f:
    f.write(content)

print("Done with formatting fixes")
