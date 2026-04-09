#!/usr/bin/env python3
#!/usr/bin/env python3
"""
patchtoc.py – Aktualisiert die Interface-Version in einer WoW-TOC-Datei

Beschreibung:
Dieses Skript liest die aktuelle Interface-Version verschiedener WoW-Clients
von der offiziellen Battle.net-Version-API aus, bereitet daraus eine
`## Interface:`-Zeile vor und patcht optional eine bestehende TOC-Datei.

Es werden alle WoW-Versionen berücksichtigt, auch PTR- und Beta-Versionen.

Features:
- Optional: TOC-Datei per Kommandozeile übergeben. Ohne Argument wird die
  Interface-Zeile nur ausgegeben.
- Alte Interface-Zeile wird farbig angezeigt:
    - Rot: gelöschte Versionsnummern
    - Grün: neue hinzugekommene Versionsnummern
- Unterstützt Windows und Linux/macOS (UTF-8-Dateien)
- Cache `.patchtoc` im Root-Laufwerk: einmal täglich wird die Online-Abfrage
  durchgeführt, um API-Anfragen zu minimieren
- Existiert die TOC-Datei nicht, wird sie erzeugt
- Interface-Zeile wird aktualisiert oder eingefügt

Verwendung:
    python patchtoc.py [<toc_datei>]

Beispiele:
    python patchtoc.py                   # Nur Interface-Zeile ausgeben
    python patchtoc.py "lalelu.toc"      # TOC-Datei aktualisieren oder erstellen

Cache:
- Die Datei `.patchtoc` im Root des Laufwerks speichert die letzte
  Interface-Zeile. Wird sie älter als 24 Stunden, erfolgt eine
  neue Online-Abfrage.

Autor: Expelliarm5s
Datum: 2025-11-23
"""

import sys
import re
import urllib.request
from pathlib import Path
import time

RED = "\033[31m"
GREEN = "\033[32m"
RESET = "\033[0m"

# Root-Verzeichnis des Laufwerks bestimmen, auf dem das Skript liegt
root = Path(__file__).resolve().anchor
CACHE_FILE = Path(root) / ".patchtoc"

CACHE_MAX_AGE = 24 * 60 * 60  # 1 Tag in Sekunden

def fetch_version(product):
    url = f"https://us.version.battle.net/v2/products/{product}/versions"
    with urllib.request.urlopen(url) as r:
        data = r.read().decode("utf-8")

    for line in data.splitlines():
        if line.startswith("us|"):
            parts = line.split("|")
            version = parts[5]
            break
    else:
        raise RuntimeError(f"Keine US-Version für {product} gefunden")

    version = version.rsplit(".", 1)[0]
    if version.startswith("1."):
        version = version.replace(".", "", 1)
    version = version.replace(".", "0")
    return version


def fetch_all_versions():
    products = [
        "wow", "wowt", "wowxptr", "wow_beta",
        "wow_classic", "wow_classic_beta", "wow_classic_ptr",
        "wow_classic_era", "wow_classic_era_ptr"
    ]

    versions = [fetch_version(p) for p in products]
    unique_sorted = sorted(set(versions), key=lambda x: int(x))
    version_string = ", ".join(unique_sorted)

    if not re.fullmatch(r"[0-9, ]+", version_string):
        raise RuntimeError(f"Ungültiges Versionsformat: {version_string}")

    return f"## Interface: {version_string}"


def load_or_update_cache():
    # Cache nicht vorhanden → neu erzeugen
    if not CACHE_FILE.exists():
        line = fetch_all_versions()
        CACHE_FILE.write_text(line + "\n", encoding="utf-8")
        return line

    # Cache existiert → Alter prüfen
    age = time.time() - CACHE_FILE.stat().st_mtime
    cached = CACHE_FILE.read_text(encoding="utf-8").strip()

    if age < CACHE_MAX_AGE and cached.startswith("## Interface:"):
        return cached  # Cache ist aktuell

    # Cache veraltet → neu generieren
    line = fetch_all_versions()
    CACHE_FILE.write_text(line + "\n", encoding="utf-8")
    return line


def extract_numbers(line):
    return set(re.findall(r"\d+", line))


def colorize_line(line, added, removed):
    def repl(m):
        num = m.group(0)
        if num in added:
            return f"{GREEN}{num}{RESET}"
        if num in removed:
            return f"{RED}{num}{RESET}"
        return num
    return re.sub(r"\d+", repl, line)


def main():
    toc_path = Path(sys.argv[1]) if len(sys.argv) == 2 else None

    # NEU: Interface-Zeile aus Cache oder Online holen
    interface_line = load_or_update_cache()

    # Keine toc-Datei → nur Ausgabe
    if toc_path is None:
        print(interface_line)
        sys.exit(0)

    # toc-Datei existiert nicht → neu anlegen
    if not toc_path.exists():
        toc_path.write_text(interface_line + "\n", encoding="utf-8")
        print(interface_line)
        sys.exit(0)

    # toc-Datei existiert → lesen
    original = toc_path.read_text(encoding="utf-8", errors="replace")

    prev_line = None
    m = re.search(r"^## Interface:.*$", original, flags=re.MULTILINE)
    if m:
        prev_line = m.group(0)

    if prev_line:
        old_nums = extract_numbers(prev_line)
        new_nums = extract_numbers(interface_line)

        removed = old_nums - new_nums
        added = new_nums - old_nums

        # Alte Zeile farbig
        print(colorize_line(prev_line, added=set(), removed=removed))
    else:
        removed = set()
        added = extract_numbers(interface_line)

    # Update der toc-Datei
    if prev_line:
        updated = re.sub(
            r"^## Interface:.*$",
            interface_line,
            original,
            flags=re.MULTILINE
        )
    else:
        updated = interface_line + "\n" + original

    toc_path.write_text(updated, encoding="utf-8")

    # Neue Zeile farbig
    print(colorize_line(interface_line, added=added, removed=set()))

    sys.exit(0)


if __name__ == "__main__":
    main()
