# Pacote de Skills — Programação Avançada Roblox

Este ZIP contém skills de agente (formato SKILL.md) que ensinam e geram código Roblox de nível de produção.

## Como usar no Grok

Se você tiver acesso à pasta de skills do Grok, copie cada pasta `roblox-*` para o diretório de skills do usuário.  
No celular, use estes arquivos como **material de estudo / referência** ao pedir código.

## Índice das skills

| Pasta | Assunto | Quando usar |
|-------|---------|-------------|
| `roblox-client-server` | Client vs Server, RemoteEvent/Function, replicação, autoridade do servidor | “client side”, “server side”, remotes, exploits |
| `roblox-networking` | Validação de argumentos, rate limit, sanitização, predição | segurança de remotes, anti-spam, FireServer |
| `roblox-datastores` | DataStore, UpdateAsync, session lock, OrderedDataStore, BindToClose | save/load, leaderboards, inventário persistente |
| `roblox-modules-architecture` | ModuleScripts, Services, Controllers, bootstrap, Shared | organização de projeto, framework, Knit-like |
| `roblox-combat-systems` | Combate com autoridade no servidor, hit arc, raycast, VFX | sword, gun, damage, PvP |
| `roblox-animations` | Animator, tracks, markers, prioridades, tool anims | tocar animação, markers, blending |
| `roblox-pathfinding-ai` | PathfindingService, patrol, chase, agent params | NPC, zumbi, bot, pathfinding |
| `roblox-advanced-gui` | GUI builder patterns — temas, explorer virtualizado, bounding box, gradient, Gui2Lua | UI avançada, GUI builder, gradiente, drag |

## Ordem sugerida de estudo

1. **roblox-client-server** — base de tudo  
2. **roblox-networking** — deixar remotes seguros  
3. **roblox-modules-architecture** — organizar o jogo  
4. **roblox-datastores** — salvar progresso  
5. **roblox-combat-systems** + **roblox-animations** — gameplay  
6. **roblox-pathfinding-ai** — NPCs  
7. **roblox-advanced-gui** — ferramentas e UI complexa  

## Estrutura de cada skill

```
roblox-nome/
  SKILL.md          ← instruções principais (o agente lê isto)
  references/       ← detalhes extras (opcional)
```

## Aviso

Estas skills ensinam práticas **server-authoritative** (o servidor decide dano, dinheiro, inventário). Código só no client é ótimo para UI e feedback, nunca para recompensas finais.
