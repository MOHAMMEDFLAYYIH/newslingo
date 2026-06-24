import re

with open('lib/core/localization/app_localizations.dart', 'r') as f:
    content = f.read()
lines = content.split('\n')

# Count inline vs multi-line isHi
hi_inline = sum(1 for l in lines if ': isHi ?' in l)
hi_multiline = sum(1 for l in lines if l.strip().startswith(': isHi'))
hi_total = sum(1 for l in lines if 'isHi' in l)
print(f'Inline isHi: {hi_inline}, Multiline isHi: {hi_multiline}, Total isHi refs: {hi_total}')

# Check for broken text segments
# Lines that look like: : ' : isEs... 
broken_lines = [i+1 for i, l in enumerate(lines) if ": ' : is" in l or ": ' : isRu" in l]
print(f'Broken lines with text fragments: {broken_lines}')
for bl in broken_lines:
    print(f'  Line {bl}: {lines[bl-1][:100]}')

# Check for $n$ patterns in Hindi text
dollar_patterns = [(i+1, l) for i, l in enumerate(lines) if re.search(r"\?\s*'[^']*\$n\$[^']*'", l)]
print(f'Lines with $$n$$: {[p[0] for p in dollar_patterns]}')
for dp in dollar_patterns[:3]:
    print(f'  Line {dp[0]}: {dp[1].strip()[:80]}')

# Check for wrong indentation on : isHi 
bad_indent = []
for i, l in enumerate(lines):
    stripped = l.lstrip()
    if stripped.startswith(': isHi') and len(l) - len(stripped) < 4:
        bad_indent.append((i+1, len(l) - len(stripped)))
print(f'\nBadly indented : isHi (<4 spaces): {len(bad_indent)}')
print(f'First 5: {bad_indent[:5]}')
