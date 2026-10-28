# enricopezzini — Marketplace personale di SKILL

Marketplace Claude Code che raccoglie le mie SKILL personali e le rende
**disponibili su qualsiasi account Claude** (personale, aziendale, condiviso da
cliente) senza doverle copiare a mano in ogni `~/.claude`.

L'idea: le skill vivono qui, in un repo git unico. Su ogni account aggiungo il
marketplace una volta e installo il plugin. Quando aggiorno una skill, basta un
`marketplace update` da ogni account per riallinearsi.

---

## Struttura

```
enricopezzini-marketplace/
├── .claude-plugin/
│   └── marketplace.json          # manifest del marketplace (nome: "enricopezzini")
├── plugins/
│   ├── llm-council/              # una skill personale = un plugin, col suo nome
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json        # manifest del plugin (nome: "llm-council")
│   │   └── skills/llm-council/SKILL.md
│   └── skill-template/            # template da copiare per nuove skill/plugin
│       ├── .claude-plugin/plugin.json
│       └── skills/skill-template/SKILL.md
└── README.md
```

- Le skill installate sono **namespaced** dal nome del plugin: si invocano come
  `/<plugin>:<skill>` (es. `/llm-council:llm-council`). Non esiste un plugin
  generico `core`: un prefisso deve dire a che cosa appartiene la skill.
- I plugin **non fissano** un `version` nel `plugin.json`: così ogni commit
  diventa automaticamente una nuova versione (versioning via SHA git). Comodo per
  un set personale che evolve spesso. Se preferisci versioni esplicite, aggiungi
  `"version": "1.0.0"` in `plugins/<plugin>/.claude-plugin/plugin.json` e **ricordati
  di incrementarla a ogni release** (altrimenti gli account vedono "già aggiornato").

---

## Installazione su un nuovo account Claude

Una volta pubblicato il repo su git (vedi sotto), su **ogni** account:

```bash
# 1. Aggiungi il marketplace (una volta per account)
claude plugin marketplace add itenricopezzini/enricopezzini-marketplace
#    oppure da URL git completo:
#    claude plugin marketplace add https://github.com/itenricopezzini/enricopezzini-marketplace.git

# 2. Installa i plugin che ti servono
claude plugin install llm-council@enricopezzini
```

Oppure dall'interno di una sessione Claude Code interattiva:

```
/plugin marketplace add itenricopezzini/enricopezzini-marketplace
/plugin install llm-council@enricopezzini
```

> Le skill **non** vengono copiate in `~/.claude`: restano gestite dal plugin
> manager nella cache plugin. È esattamente il comportamento voluto.

### Test in locale (senza git)

Per provare prima di pubblicare, puoi aggiungere il marketplace da path locale:

```bash
claude plugin marketplace add "C:/Users/Enrico.Pezzini/projectz/skills/enricopezzini-marketplace"
claude plugin install llm-council@enricopezzini
```

> Nota: le `source` con path relativo (`./plugins/llm-council`) funzionano sia da path
> locale sia quando il marketplace è aggiunto via git. Non funzionano invece se
> punti direttamente a un URL del solo `marketplace.json`.

---

## Aggiornare le skill su tutti gli account

Dopo aver fatto push di nuove modifiche al repo:

```bash
claude plugin marketplace update enricopezzini   # riallinea il manifest
claude plugin update llm-council@enricopezzini    # aggiorna un plugin installato
```

### Script pronto (pull + update + reinstall)

In alternativa c'è uno script che fa tutto in un colpo — `git pull`, riallineamento
del manifest e reinstallazione del plugin. Usa il path del repo dove si trova, quindi
funziona da qualsiasi account:

```powershell
# Windows / PowerShell
pwsh ./scripts/update-local.ps1
```

```bash
# macOS / Linux
./scripts/update-local.sh
```

---

## Aggiungere una nuova skill

1. Copia `plugins/skill-template/` in `plugins/<nome-skill>/` (il plugin prende il nome della skill:
   così il prefisso resta sensato, `/<nome-skill>:<nome-skill>`), rinomina `skills/skill-template/`
   in `skills/<nome-skill>/` e aggiorna `name` in `.claude-plugin/plugin.json`.
2. Aggiungi il plugin all'array `plugins` in `.claude-plugin/marketplace.json`.
3. Aggiorna il frontmatter (`name`, `description`) e scrivi le istruzioni.
4. Rimuovi `disable-model-invocation: true` se vuoi l'auto-invocazione.
5. Commit + push.
6. Su ogni account: `marketplace update` + reinstalla (vedi sopra).

Più skill affini possono stare nello stesso plugin (es. `client-x`, `dev`, `writing`): il nome
del plugin deve però descrivere l'insieme, mai essere un contenitore generico.

---

## Pubblicazione iniziale su GitHub

```bash
git init
git add .
git commit -m "Initial commit: marketplace personale di SKILL"
# crea il repo remoto (richiede gh autenticato):
"/c/Program Files/GitHub CLI/gh.exe" repo create enricopezzini-marketplace --private --source=. --push
```

---

## Plugin `pstack`

57 skill di [pstack](https://github.com/cursor/plugins/tree/main/pstack) (Lauren Tan, MIT),
riscritte per non dipendere da Cursor o Claude Code. Plugin separato: si invocano
come `/pstack:<skill>` (es. `/pstack:interrogate`, `/pstack:blast-radius`).

```bash
claude plugin install pstack@enricopezzini
```

I modelli per ruolo si configurano una volta con `/pstack:setup-pstack` (sezione `pstack models`
nelle istruzioni dell'agent). Dettagli e adattamenti in `plugins/pstack/NOTICE.md`.

---

## Prefisso dei plugin

Ogni skill si invoca con il prefisso del suo plugin (`/pstack:tdd`, `/mattpocock:tdd`, `/caveman:core-caveman`,
`/caveman:caveman`): lo stesso nome in plugin diversi non collide. Le skill vanno quindi installate come
plugin (`claude plugin install <plugin>@enricopezzini`), non copiate in cartelle flat come
`.claude/skills/`, dove il prefisso si perde. `scripts/check-duplicates.sh` verifica che dentro un
singolo plugin non ci siano due skill con lo stesso nome.

---

## Plugin `mattpocock`

27 skill di [mattpocock/skills](https://github.com/mattpocock/skills) (Matt Pocock, MIT),
copiate verbatim: grilling, spec/ticket flow, TDD, code review, domain modelling e altro.
Plugin separato: si invocano come `/mattpocock:<skill>` (es. `/mattpocock:tdd`,
`/mattpocock:grill-with-docs`, `/mattpocock:code-review`).

```bash
claude plugin install mattpocock@enricopezzini
```

Prima configurazione consigliata con `/mattpocock:setup-matt-pocock-skills`.
Provenienza e dettagli in `plugins/mattpocock/NOTICE.md`.

---

## Plugin `caveman`

22 skill di [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) (Julius Brussee, Apache-2.0),
copiate verbatim: output compresso, commit/review concisi, esplorazione e refactor mirati.
Plugin separato: si invocano come `/caveman:<skill>` (es. `/caveman:caveman`,
`/caveman:caveman-commit`, `/caveman:caveman-review`).

```bash
claude plugin install caveman@enricopezzini
```

Provenienza e dettagli in `plugins/caveman/NOTICE.md`.
