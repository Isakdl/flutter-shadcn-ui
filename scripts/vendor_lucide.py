#!/usr/bin/env python3
# Regenerates fonts/Lucide.ttf and lib/src/assets/lucide_icons.dart from
# scripts/lucide_icon_names.txt. Add icon names to that file, then run:
#   python3 scripts/vendor_lucide.py <path-to-lucide_icons_flutter-package>
# Requires: pip install fonttools. Run `dart format` on the output after.
import re, sys, os
repo = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
pkg = sys.argv[1]
src = re.sub(r'\s+', ' ', open(os.path.join(pkg, 'lib/lucide_icons.dart')).read())
decls = dict(re.findall(r'static const IconData (\w+) = const LucideIconData\((\d+)\)', src))
names = [l.strip() for l in open(os.path.join(repo, 'scripts/lucide_icon_names.txt')) if l.strip()]
missing = [n for n in names if n not in decls]
if missing:
    print("MISSING:", missing); sys.exit(1)
cps = {n: int(decls[n]) for n in names}
from fontTools import subset
opts = subset.Options()
# 300-weight instance: same codepoints as the default font, thinner strokes.
f = subset.load_font(
    os.path.join(pkg, 'assets/build_font/LucideVariable-w300.ttf'), opts)
s = subset.Subsetter(opts)
s.populate(unicodes=list(cps.values()))
s.subset(f)
out = os.path.join(repo, 'fonts/Lucide.ttf')
subset.save_font(f, out, opts)
lines = ["import 'package:flutter/widgets.dart';", "",
 "/// Subset of Lucide icons used by shadcn_ui and Serverpod Cloud apps.",
 "/// Regenerate with scripts/vendor_lucide.py when adding icons.",
 "abstract final class LucideIcons {"]
for n in sorted(cps):
    lines.append(f"  static const IconData {n} = IconData({hex(cps[n])}, fontFamily: 'Lucide', fontPackage: 'shadcn_ui');")
lines.append("}")
open(os.path.join(repo, 'lib/src/assets/lucide_icons.dart'), 'w').write('\n'.join(lines) + '\n')
print(f"icons: {len(cps)}, font: {os.path.getsize(out)} bytes")
