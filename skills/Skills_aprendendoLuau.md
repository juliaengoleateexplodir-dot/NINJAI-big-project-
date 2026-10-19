---
name: roblox-luau-complete-guide
description: Referência abrangente para ensinar, escrever, revisar e depurar Luau no Roblox usando fontes oficiais, exemplos e boas práticas.
---

# Skill: Programação Luau no Roblox — Guia Completo

## Objetivo e regras de uso

Use esta skill para explicar conceitos, criar scripts, corrigir erros e orientar arquitetura de jogos Roblox. Responda em português claro, explique onde cada script deve ficar no Explorer e forneça exemplos pequenos que possam ser testados. Prefira APIs oficiais e nunca invente nomes de classes, propriedades, eventos ou métodos. A documentação evolui; confirme APIs específicas na referência atual antes de afirmar detalhes sensíveis à versão.

## 1. O que é Luau?

Luau é a linguagem de scripting usada no Roblox Studio. Deriva de Lua 5.1, com melhorias de desempenho, recursos adicionais e tipagem gradual opcional. Código Lua 5.1 válido geralmente também é válido em Luau, mas o inverso não é garantido.

```lua
print("Olá, Roblox!")
```

`print()` escreve na janela Output do Studio; não cria texto na interface do jogador.

Luau pode controlar objetos, responder a eventos, criar GUIs, lidar com entrada do jogador, movimentar NPCs, comunicar cliente e servidor e trabalhar com dados persistentes usando serviços apropriados.

## 2. DataModel e Explorer

O Roblox organiza o jogo numa hierarquia de objetos chamada **DataModel**, visível no Explorer. Cada objeto é uma `Instance`; objetos têm classes, propriedades, métodos, eventos e um `Parent`.

Locais importantes:

- `Workspace`: mundo 3D, peças, modelos e cenário.
- `Players`: jogadores conectados e objetos `Player`.
- `ReplicatedStorage`: objetos compartilhados/replicados, como módulos e remotes.
- `ServerScriptService`: lógica de servidor que não deve ser exposta ao cliente.
- `ServerStorage`: modelos e objetos apenas do servidor.
- `StarterGui`: interfaces copiadas para `PlayerGui`.
- `StarterPlayer > StarterPlayerScripts`: scripts gerais do cliente.
- `StarterPlayer > StarterCharacterScripts`: scripts associados ao personagem.
- `StarterPack`: ferramentas copiadas para a mochila do jogador.
- `Lighting`: iluminação e efeitos visuais.
- `SoundService`: configuração de áudio.

```lua
local part = workspace:WaitForChild("MinhaPeca")
part.Transparency = 0.5
```

`WaitForChild()` aguarda um filho com aquele nome. Se houver espera infinita, verifique nome, caminho, contexto e se o objeto realmente será criado.

## 3. Tipos de script

### `Script`
Normalmente executa lógica do servidor quando está num contêiner compatível. Use para regras confiáveis: validar recompensas, aplicar dano, controlar estado compartilhado e salvar dados.

### `LocalScript`
Executa no cliente em locais permitidos, como `StarterPlayerScripts`, `StarterCharacterScripts`, `PlayerGui` e `Backpack`. Use para GUI, câmera e entrada local. Não confie nele para decisões de segurança.

### `ModuleScript`
Contém código reutilizável carregado com `require()`. Executa no contexto do script que o requer; não é, por si só, um mecanismo de rede.

```lua
-- ModuleScript chamado MathUtil
local MathUtil = {}
function MathUtil.add(a: number, b: number): number
    return a + b
end
return MathUtil
```

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MathUtil = require(ReplicatedStorage:WaitForChild("MathUtil"))
print(MathUtil.add(2, 3))
```

## 4. Cliente, servidor e replicação

Roblox usa arquitetura cliente-servidor:

- **Servidor**: autoridade sobre estado compartilhado e regras importantes.
- **Cliente**: interface, câmera, entrada e efeitos locais de cada jogador.
- **Replicação**: sincroniza determinados objetos e alterações.
- **RemoteEvent**: comunicação assíncrona.
- **RemoteFunction**: comunicação que aguarda resposta; use com cuidado para não bloquear fluxos importantes.

O servidor deve validar solicitações que alterem moedas, inventário, dano, compras, progresso ou estado competitivo. Nunca aceite cegamente dados enviados pelo cliente.

```lua
-- Script no servidor; RequestPurchase é um RemoteEvent em ReplicatedStorage.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local requestPurchase = ReplicatedStorage:WaitForChild("RequestPurchase")

requestPurchase.OnServerEvent:Connect(function(player, itemId)
    if typeof(itemId) ~= "string" then return end
    -- Validar item permitido, preço real, saldo, estado e frequência.
    -- Somente depois atualizar o estado autoritativo no servidor.
end)
```

Esse exemplo mostra o formato básico, não uma loja completa. Valide permissões, limites, distância, estado atual e frequência. O cliente não deve determinar o preço final.

## 5. Variáveis, escopo e atribuição

```lua
local coins = 25
local playerName = "PlayerOne"
coins += 5
print(playerName, coins)
```

- `local`: limita a variável ao bloco/função.
- `=`: atribuição; `==`: comparação.
- `nil`: ausência de valor.
- `..`: concatenação de strings.
- Prefira `local` para evitar globais acidentais.

```lua
local message = "fora"
local function example()
    local inner = "dentro"
    print(message, inner)
end
example()
```

`inner` só existe dentro da função. `const` não é a declaração comum de variável em Luau; use `local`, anotações de tipo e estruturas apropriadas.

## 6. Tipos de dados

- `nil`: ausência de valor.
- `boolean`: `true` ou `false`.
- `number`: números inteiros ou decimais.
- `string`: texto.
- `table`: lista, dicionário ou estrutura composta.
- `function`: função.
- `thread`: thread/coroutine.
- `userdata`, `vector` e `buffer`: tipos especiais da implementação Luau.
- `Instance`: objetos do Roblox; `typeof()` reconhece tipos específicos do engine.
- `Enum`: conjunto fixo de opções, como `Enum.Material.Neon`.

```lua
local isReady: boolean = true
local health: number = 100
local username: string = "Ninja"
local itemNames: {string} = {"Espada", "Poção"}
print(typeof(workspace), type(health))
```

`type()` retorna tipos Luau básicos; `typeof()` também distingue tipos específicos do Roblox, como `Instance` e `Vector3`.

## 7. Strings

```lua
local name = "Bah"
local score = 120
print(`Jogador {name} tem {score} pontos`)
```

Luau suporta interpolação com crases. Funções úteis incluem `string.lower`, `string.upper`, `string.find`, `string.sub`, `string.gsub` e `string.format`. Consulte a documentação para padrões e casos específicos.

## 8. Operadores

- Aritméticos: `+`, `-`, `*`, `/`, `//`, `%`, `^`.
- Comparação: `==`, `~=`, `<`, `>`, `<=`, `>=`.
- Lógicos: `and`, `or`, `not`.
- Concatenação: `..`.
- Comprimento: `#`.
- Atribuição composta: `+=`, `-=`, `*=`, `/=` e outros suportados.

```lua
local total = 10 + 5
local label = "Pontos: " .. total
if total >= 15 and total < 100 then
    print(label)
end
```

`~=` significa diferente. Em condições, apenas `false` e `nil` são falsos; `0` e `""` são verdadeiros.

## 9. Condicionais e laços

```lua
local health = 40
if health <= 0 then
    print("Derrotado")
elseif health < 50 then
    print("Pouca vida")
else
    print("Tudo certo")
end
```

Laço numérico:

```lua
for i = 1, 5 do
    print(i)
end
```

Arrays e dicionários:

```lua
local fruits = {"maçã", "uva", "pera"}
for index, fruit in ipairs(fruits) do print(index, fruit) end

local prices = {apple = 3, grape = 5}
for name, price in pairs(prices) do print(name, price) end

-- Luau também aceita iteração generalizada:
for key, value in prices do print(key, value) end
```

`while` e `repeat`:

```lua
local count = 0
while count < 3 do count += 1 end
repeat count -= 1 until count == 0
```

Evite laços infinitos sem pausas; podem congelar ou prejudicar o desempenho. Prefira eventos quando possível.

## 10. Funções e retornos

```lua
local function multiply(a: number, b: number): number
    return a * b
end
print(multiply(4, 3))
```

Parâmetros são dados recebidos; `return` devolve um resultado e encerra a função. Funções anônimas são comuns em callbacks. Funções podem acessar variáveis do escopo externo (closures). Use nomes claros e divida funções grandes por responsabilidade.

## 11. Tabelas: arrays e dicionários

```lua
local inventory = {"Key", "Potion"}
print(inventory[1]) -- sequências normalmente começam em 1

local profile = {
    coins = 50,
    level = 4,
    settings = {music = true},
}
print(profile.coins, profile.settings.music)
```

`table.insert`, `table.remove`, `table.sort`, `table.concat` e `table.find` são úteis em situações específicas. `#t` funciona melhor em sequências sem lacunas; não é uma contagem universal de todas as chaves. Atribuir `nil` remove uma chave.

## 12. Tipagem gradual e modo strict

```lua
--!strict

type PlayerStats = {
    Coins: number,
    Level: number,
}

local stats: PlayerStats = {Coins = 0, Level = 1}
local function addCoins(amount: number): number
    stats.Coins += amount
    return stats.Coins
end
```

`--!strict` pede verificação estática rigorosa. `--!nonstrict` usa modo menos rigoroso. `--!nocheck` desativa análise estática naquele script e normalmente não é uma boa maneira de corrigir erros. Tipos ajudam a encontrar problemas, mas não substituem validação em tempo de execução nem segurança no servidor.

## 13. Instâncias, propriedades, métodos e eventos

- **Propriedade**: dado do objeto, por exemplo `Part.Transparency`.
- **Método**: ação, por exemplo `Instance:Destroy()`.
- **Evento**: sinal para reagir, por exemplo `BasePart.Touched`.
- **Classe**: tipo de objeto, por exemplo `Part`, `TextLabel` ou `RemoteEvent`.
- **Parent**: objeto pai na hierarquia.

```lua
local part = Instance.new("Part")
part.Name = "DemoPart"
part.Size = Vector3.new(4, 1, 4)
part.Anchored = true
part.Position = Vector3.new(0, 5, 0)
part.Parent = workspace
```

Defina propriedades antes de colocar objetos no mundo quando isso evitar estados intermediários desnecessários.

## 14. Serviços e `GetService`

```lua
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
```

Serviços comuns:

- `Players`: jogadores e personagens.
- `Workspace`: mundo 3D.
- `ReplicatedStorage`: conteúdo compartilhado.
- `ServerScriptService`: lógica de servidor.
- `ServerStorage`: conteúdo privado do servidor.
- `TweenService`: animação de propriedades.
- `RunService`: eventos do ciclo de execução.
- `UserInputService`: teclado, mouse e toque no cliente.
- `ContextActionService`: ações associadas a controles.
- `CollectionService`: tags de instâncias.
- `HttpService`: JSON e recursos HTTP sujeitos a permissões.
- `DataStoreService`: persistência para experiências publicadas.
- `MarketplaceService`: fluxos oficiais de produtos e compras.
- `PathfindingService`: caminhos de NPCs.
- `Debris`: remoção agendada de objetos.
- `SoundService`: configuração de áudio.

Confirme métodos, eventos e restrições na API Reference oficial.

## 15. Eventos e conexões

```lua
local part = workspace:WaitForChild("TouchPart")
local connection = part.Touched:Connect(function(hit)
    print("Tocou:", hit.Name)
end)
-- Quando não for mais necessário: connection:Disconnect()
```

`Connect()` cria uma conexão. Guarde-a para desconectar quando necessário. Eventos podem disparar várias vezes; proteja operações que não devem repetir. `Touched` depende de contato físico e não substitui todos os tipos de interação.

## 16. `task` e tarefas agendadas

```lua
task.wait(1)
task.delay(2, function() print("Dois segundos depois") end)
task.spawn(function() print("Tarefa agendada") end)
task.defer(function() print("Executa em etapa posterior") end)
```

O tempo real pode variar com a carga. Não use temporizadores do cliente como autoridade para economia, compras ou segurança. Evite lançar milhares de tarefas sem controle.

## 17. RunService e atualização por frame

`RunService` oferece eventos ligados ao ciclo do engine. `PreRender` é adequado para trabalho que precisa ocorrer antes de renderizar; `Heartbeat` ocorre após a simulação física; `PreSimulation` ocorre antes dela. Escolha o evento conforme a tarefa e confirme a API atual. `RenderStepped` aparece em código legado; verifique a recomendação vigente para o caso de uso.

Evite atualizar muitos objetos a cada frame sem necessidade. Considere eventos, `TweenService`, animações ou física do engine.

## 18. Interface gráfica (GUI)

Classes comuns:

- `ScreenGui`: interface na tela.
- `Frame`: painel/contêiner.
- `TextLabel`: texto de exibição.
- `TextButton`: botão com texto.
- `ImageLabel` / `ImageButton`: imagem.
- `TextBox`: entrada de texto.
- `ScrollingFrame`: conteúdo rolável.
- `UIListLayout` / `UIGridLayout`: organização automática.
- `UIPadding`: margens internas.
- `UICorner`: cantos arredondados.
- `UIStroke`: contorno.
- `UIScale`: escala visual.
- `UIAspectRatioConstraint`: proporção.
- `UISizeConstraint`: limites de tamanho.

```lua
-- LocalScript em contexto de cliente
local Players = game:GetService("Players")
local gui = Instance.new("ScreenGui")
gui.Name = "DemoGui"
gui.ResetOnSpawn = false
gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.fromOffset(180, 44)
button.Position = UDim2.fromOffset(20, 20)
button.Text = "Clique aqui"
button.Parent = gui
button.Activated:Connect(function()
    button.Text = "Funcionou!"
end)
```

`Activated` é útil para mouse, toque e controles suportados. Para PC e mobile, prefira tamanhos relativos, `AnchorPoint`, layouts e constraints, e teste resoluções diferentes.

## 19. Entrada do jogador

`UserInputService` consulta entrada no cliente; `ContextActionService` associa ações a vários controles; `GuiButton.Activated` simplifica botões multiplataforma. Nunca use entrada local como prova de que alguém pode receber uma recompensa: o servidor deve verificar a ação.

## 20. Vetores, CFrame e dimensões GUI

- `Vector2`: coordenadas 2D.
- `Vector3`: posição/direção/velocidade 3D.
- `CFrame`: posição e orientação 3D.
- `UDim2`: layout GUI com escala e offset.
- `UDim`: dimensão com escala e offset.
- `Color3`: cor.
- `Enum`: opções nomeadas.

```lua
local part = workspace:WaitForChild("DemoPart")
part.Position = Vector3.new(0, 5, 0)
part.CFrame = CFrame.new(0, 5, 0) * CFrame.Angles(0, math.rad(45), 0)
```

`Position` define posição; `CFrame` representa posição e orientação. Considere ancoragem, colisões e física.

## 21. TweenService e animações

```lua
local TweenService = game:GetService("TweenService")
local part = workspace:WaitForChild("DemoPart")
local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(part, info, {
    Transparency = 0.5,
    Position = part.Position + Vector3.new(0, 2, 0),
})
tween:Play()
```

Evite criar tweens ilimitados ou animar a mesma propriedade de formas conflitantes. Para personagens, `Animation` e `Animator` têm requisitos específicos na documentação oficial.

## 22. Jogadores e personagens

Eventos frequentes: `Players.PlayerAdded`, `Players.PlayerRemoving`, `Player.CharacterAdded`, `Humanoid.Died` e `Humanoid.HealthChanged`.

```lua
local Players = game:GetService("Players")
Players.PlayerAdded:Connect(function(player)
    print(player.Name .. " entrou")
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.HealthChanged:Connect(function(health)
            print(player.Name, health)
        end)
    end)
end)
```

Não assuma que `Character`, `Humanoid` ou partes do corpo já existem. Aguarde e trate ausências, respawns e conexões duplicadas.

## 23. RemoteEvents e RemoteFunctions

Cliente:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("RequestAction")
remote:FireServer("OpenDoor")
```

Servidor:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("RequestAction")
remote.OnServerEvent:Connect(function(player, action)
    if action ~= "OpenDoor" then return end
    -- Verifique distância, chave, estado da porta,
    -- permissões e frequência no servidor.
end)
```

O primeiro argumento de `OnServerEvent` é o `Player` remetente. Não confie num UserId enviado como argumento quando o Roblox já informa quem enviou. Use `RemoteFunction` somente quando a resposta imediata for necessária; considere falhas e bloqueios.

## 24. DataStoreService

`DataStoreService` persiste dados entre sessões. O acesso deve ser feito pelo servidor; chamadas podem falhar e têm limites.

Boas práticas:
- proteger chamadas com `pcall`;
- usar `UpdateAsync` quando a atualização depende do valor atual;
- validar e versionar o formato;
- lidar com falhas e tentativas com espera;
- não salvar a cada frame;
- evitar segredos nos dados expostos ao cliente;
- testar com cuidado e seguir as configurações de acesso do Studio.

```lua
local DataStoreService = game:GetService("DataStoreService")
local store = DataStoreService:GetDataStore("PlayerCoins_v1")

local function saveCoins(userId: number, coins: number)
    local key = "user_" .. userId
    local ok, err = pcall(function()
        store:SetAsync(key, coins)
    end)
    if not ok then warn("Falha ao salvar:", err) end
end
```

Este exemplo não implementa carregamento completo, concorrência, saída do jogador nem política de repetição; não é um sistema de dados pronto para produção.

## 25. HttpService e JSON

`JSONEncode()` converte dados compatíveis em JSON; `JSONDecode()` converte JSON para valores Luau. Requisições HTTP dependem de configurações e regras da plataforma.

```lua
local HttpService = game:GetService("HttpService")
local payload = {message = "hello", count = 3}
local json = HttpService:JSONEncode(payload)
print(json)
```

Nunca coloque tokens, senhas ou chaves secretas em `LocalScript`, GUI ou conteúdo replicado. Integrações que exigem segredo devem usar um backend seguro e validar as entradas.

## 26. Depuração e erros

- `print()`: informação normal no Output.
- `warn()`: aviso.
- `error()`: gera erro.
- `assert()`: falha se condição obrigatória não for verdadeira.
- `pcall()`: executa uma função protegendo o chamador de erro não tratado.
- `xpcall()`: versão com função de tratamento de erro.
- Script Analysis e type checking: detectam problemas no editor.

```lua
local ok, result = pcall(function()
    return 10 / 2
end)
if ok then
    print(result)
else
    warn("Operação falhou:", result)
end
```

Não envolva todo o script em `pcall` para esconder erros. Registre contexto útil e trate falhas esperadas.

## 27. Módulos e arquitetura

Separe responsabilidades: configuração, lógica de inventário, UI, entrada, lógica autoritativa do servidor e comunicação remota. Evite um único script enorme e ciclos de `require()`. Um `ModuleScript` executa no contexto de quem o requer; não presuma que APIs exclusivas do cliente existam no servidor.

## 28. Metatables e OOP simples

Metatables personalizam o comportamento de tabelas, por exemplo com `__index`. São úteis em alguns padrões, mas não necessárias para todo projeto.

```lua
local Counter = {}
Counter.__index = Counter
function Counter.new()
    return setmetatable({Value = 0}, Counter)
end
function Counter:Add(amount: number)
    self.Value += amount
end
local counter = Counter.new()
counter:Add(2)
print(counter.Value)
```

`self` é uma convenção para a tabela/objeto atual em chamadas com `:`. `counter:Add(2)` passa `counter` como `self`.

## 29. Física, raycasting e colisões

- `BasePart.Touched`: evento de contato físico.
- `Workspace:Raycast()`: lança um raio e retorna o primeiro resultado atingido.
- `RaycastParams`: define filtros.
- `CanCollide`, `CanTouch` e `CanQuery`: controlam aspectos diferentes de interação.
- `Anchored`: impede o movimento físico normal da peça.

```lua
local Workspace = game:GetService("Workspace")
local origin = Vector3.new(0, 10, 0)
local direction = Vector3.new(0, -20, 0)
local result = Workspace:Raycast(origin, direction)
if result then
    print("Atingiu:", result.Instance:GetFullName())
    print("Posição:", result.Position)
end
```

Consulte `RaycastParams` para excluir o próprio personagem, filtrar objetos e configurar grupos de colisão.

## 30. Pathfinding de NPCs

`PathfindingService` calcula caminhos com base em parâmetros do agente e obstáculos conhecidos. O jogo precisa mover o NPC, verificar falhas e recalcular quando necessário. Um caminho calculado não garante que o NPC consiga completá-lo em qualquer situação. Consulte a documentação oficial para `CreatePath`, `ComputeAsync`, waypoints e `Humanoid:MoveTo()`.

## 31. Desempenho e anti-lag

- Prefira eventos a loops por frame quando possível.
- Reutilize objetos em vez de criar/destruir milhares sem necessidade.
- Desconecte eventos e encerre tarefas quando objetos ou interfaces forem removidos.
- Evite trabalho caro a cada frame.
- Limite listas e dados recebidos.
- Use ferramentas de profiling do Studio para localizar gargalos reais.
- Em GUIs grandes, crie conteúdo sob demanda, use rolagem e evite recriar toda a árvore repetidamente.
- Não lance milhares de tarefas sem controle.
- Evite conexões duplicadas após respawn ou abertura repetida de UI.

## 32. Segurança

- O servidor valida ações importantes.
- O cliente não é autoridade para moedas, dano, inventário, compras ou permissões.
- Valide tipos, limites, distâncias, estado do jogo e frequência de chamadas.
- Não confie em nomes, preços, IDs ou quantidades enviados pelo cliente sem verificação.
- Mantenha segredos fora de scripts replicados.
- Use sistemas oficiais da plataforma para compras e persistência.
- Revise código externo desconhecido antes de executá-lo.

## 33. Erros comuns

1. **`attempt to index nil`**: variável/instância é `nil`; confira nome, contexto e ordem de carregamento.
2. **`Infinite yield possible on WaitForChild`**: o filho não apareceu; confira caminho e nome.
3. **GUI não aparece**: verifique `ScreenGui`, `PlayerGui`/`StarterGui` e execução no cliente.
4. **LocalScript não roda**: confira se está num contêiner permitido.
5. **RemoteEvent não funciona**: confira existência, nome, direção e argumentos.
6. **DataStore falha**: confira contexto de servidor, configurações, permissões e tratamento de erro.
7. **Código roda muitas vezes**: verifique conexões duplicadas e eventos repetidos.
8. **Entrada inválida**: valide dados; use `tonumber()` quando apropriado.
9. **Erro de sintaxe**: confira `end`, parênteses, vírgulas, aspas e nomes de propriedades.

## 34. Fluxo recomendado para implementar funcionalidades

1. Defina comportamento esperado e casos de erro.
2. Escolha o contexto: servidor, cliente ou ambos.
3. Coloque o script no local correto do Explorer.
4. Consulte a documentação da classe, serviço ou método.
5. Implemente uma versão pequena e isolada.
6. Valide entradas e permissões no servidor.
7. Teste com Play e, quando houver rede, Start Server e múltiplos clientes.
8. Confira Output e Script Analysis.
9. Teste respawn, saída, telas pequenas e falhas de rede.
10. Meça desempenho e revise segurança antes de publicar.

## 35. Como esta skill deve responder

Quando receber um pedido de programação Luau:

1. Explique arquitetura e local de instalação.
2. Se o usuário pedir código completo, forneça o código completo sem omitir partes essenciais.
3. Use APIs documentadas e não invente membros.
4. Distinga exemplos didáticos de sistemas prontos para produção.
5. Para erros, explique causa provável, correção e como verificar.
6. Para interface, considere PC, mobile, controles e acessibilidade quando relevante.
7. Para rede, economia, dados e permissões, mantenha a autoridade no servidor.
8. Não prometa “sem bugs”; descreva limitações e testes necessários.
9. Se a API puder ter mudado, consulte documentação atual e cite a página.
10. Não trate executores de terceiros como equivalentes ao ambiente suportado do Roblox Studio; prefira o fluxo oficial de criação e teste.

## 36. Fontes oficiais

Use estas referências primárias:

- **Luau — Roblox Creator Hub:** https://create.roblox.com/docs/luau
- **Scripting — Roblox Creator Hub:** https://create.roblox.com/docs/scripting
- **Fundamentos de programação (PT-BR):** https://create.roblox.com/docs/pt-br/tutorials/fundamentals/coding-1/coding-fundamentals
- **Criar um script (PT-BR):** https://create.roblox.com/docs/pt-br/tutorials/fundamentals/coding-1/create-a-script
- **Modelo de dados (PT-BR):** https://create.roblox.com/docs/pt-br/projects/data-model
- **Documentação oficial do projeto Luau:** https://luau.org/
- **Referência da API do engine Roblox:** https://create.roblox.com/docs/reference/engine

### Regra de confiabilidade

Priorize Roblox Creator Hub para comportamento do engine e serviços Roblox; use Luau.org para detalhes da linguagem. Se houver divergência, confira versão, contexto de execução e documentação atual. Não invente citações nem afirme que um recurso existe sem confirmação.
