# Security Policy

## Scope

This repository ships **Claude Code Agent Skills** — Markdown instruction files (`SKILL.md`) plus two install scripts (`install.sh`, `install.ps1`). There is no server, no runtime service, and no data collection. The realistic attack surface is small:

- the **install scripts** (they copy files into your `.claude/skills/`), and
- the **skill instructions** themselves (a malicious edit could try to steer an agent toward unsafe actions).

The skills are **read-oriented reviewers** (`allowed-tools: Read, Grep, Glob, Bash, Write`) — they inspect a repo and write a report. Review a skill before installing it, the same as any code you run.

## Reporting a Vulnerability

If you find a security issue — e.g. an install script flaw, or a skill that could be coaxed into a destructive or data-exfiltrating action — please report it **privately**:

- Open a [GitHub private security advisory](https://docs.github.com/en/code-security/security-advisories), or
- Email **vikast908@gmail.com**.

Please do **not** open a public issue for a security report. We'll acknowledge within a few days and aim to address confirmed issues promptly, crediting you unless you prefer otherwise.

## Supported Versions

The `main` branch is the supported version.
