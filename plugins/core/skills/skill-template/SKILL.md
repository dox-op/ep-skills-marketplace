---
name: skill-template
description: TEMPLATE di partenza per una nuova SKILL. Copia questa cartella, rinominala e sostituisci i contenuti. Non è pensata per essere invocata in produzione.
disable-model-invocation: true
---

# Skill template

Questo è uno scheletro di SKILL. Per crearne una nuova:

1. Copia la cartella `skills/skill-template/` in `skills/<nome-skill>/`.
2. Rinomina/aggiorna il campo `name` nel frontmatter (kebab-case).
3. Scrivi una `description` chiara: descrive **cosa fa** e **quando usarla** — Claude la legge per decidere l'auto-invocazione.
4. Rimuovi `disable-model-invocation: true` se vuoi che Claude possa invocarla in autonomia.
5. Sostituisci queste istruzioni con il contenuto reale della skill.

## Frontmatter disponibile (riferimento rapido)

```yaml
---
name: nome-skill                 # kebab-case; default = nome cartella
description: cosa fa e quando     # consigliata; usata per l'auto-invocazione
allowed-tools: "Read Grep Bash"   # tool pre-approvati mentre la skill è attiva
disallowed-tools: "Write Edit"    # tool rimossi mentre la skill è attiva
model: sonnet                     # override del modello (o "inherit")
effort: high                      # low | medium | high | xhigh | max
context: fork                     # esegue la skill in un subagent isolato
agent: Explore                    # tipo di subagent quando context: fork
argument-hint: "[file]"           # hint mostrato nell'autocomplete
disable-model-invocation: false   # true = solo l'utente può invocarla
user-invocable: true              # false = nascosta dal menu /, solo Claude
---
```

## Istruzioni

Scrivi qui, in markdown, cosa deve fare Claude quando la skill è attiva.
Puoi includere file di supporto nella stessa cartella (es. `reference.md`, `scripts/`).
