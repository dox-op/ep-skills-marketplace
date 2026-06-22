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
│   └── core/                     # plugin che impacchetta tutte le skill
│       ├── .claude-plugin/
│       │   └── plugin.json        # manifest del plugin (nome: "core")
│       └── skills/
│           └── skill-template/    # template da copiare per nuove skill
│               └── SKILL.md
└── README.md
```

- Le skill installate sono **namespaced** dal nome del plugin: si invocano come
  `/core:nome-skill`.
- Il plugin `core` **non fissa** un `version` nel `plugin.json`: così ogni commit
  diventa automaticamente una nuova versione (versioning via SHA git). Comodo per
  un set personale che evolve spesso. Se preferisci versioni esplicite, aggiungi
  `"version": "1.0.0"` in `plugins/core/.claude-plugin/plugin.json` e **ricordati
  di incrementarla a ogni release** (altrimenti gli account vedono "già aggiornato").

---

## Installazione su un nuovo account Claude

Una volta pubblicato il repo su git (vedi sotto), su **ogni** account:

```bash
# 1. Aggiungi il marketplace (una volta per account)
claude plugin marketplace add itenricopezzini/enricopezzini-marketplace
#    oppure da URL git completo:
#    claude plugin marketplace add https://github.com/itenricopezzini/enricopezzini-marketplace.git

# 2. Installa il plugin con tutte le skill
claude plugin install core@enricopezzini
```

Oppure dall'interno di una sessione Claude Code interattiva:

```
/plugin marketplace add itenricopezzini/enricopezzini-marketplace
/plugin install core@enricopezzini
```

> Le skill **non** vengono copiate in `~/.claude`: restano gestite dal plugin
> manager nella cache plugin. È esattamente il comportamento voluto.

### Test in locale (senza git)

Per provare prima di pubblicare, puoi aggiungere il marketplace da path locale:

```bash
claude plugin marketplace add "C:/Users/Enrico.Pezzini/projectz/skills/enricopezzini-marketplace"
claude plugin install core@enricopezzini
```

> Nota: le `source` con path relativo (`./plugins/core`) funzionano sia da path
> locale sia quando il marketplace è aggiunto via git. Non funzionano invece se
> punti direttamente a un URL del solo `marketplace.json`.

---

## Aggiornare le skill su tutti gli account

Dopo aver fatto push di nuove modifiche al repo:

```bash
claude plugin marketplace update enricopezzini   # riallinea il manifest
claude plugin install core@enricopezzini          # reinstalla l'ultima versione
```

---

## Aggiungere una nuova skill

1. Copia `plugins/core/skills/skill-template/` in `plugins/core/skills/<nome-skill>/`.
2. Aggiorna il frontmatter (`name`, `description`) e scrivi le istruzioni.
3. Rimuovi `disable-model-invocation: true` se vuoi l'auto-invocazione.
4. Commit + push.
5. Su ogni account: `marketplace update` + reinstalla (vedi sopra).

Per separare le skill in **più plugin** (es. `client-x`, `dev`, `writing`),
crea altre cartelle sotto `plugins/` con la loro `.claude-plugin/plugin.json` e
aggiungile all'array `plugins` in `.claude-plugin/marketplace.json`.

---

## Pubblicazione iniziale su GitHub

```bash
git init
git add .
git commit -m "Initial commit: marketplace personale di SKILL"
# crea il repo remoto (richiede gh autenticato):
"/c/Program Files/GitHub CLI/gh.exe" repo create enricopezzini-marketplace --private --source=. --push
```
