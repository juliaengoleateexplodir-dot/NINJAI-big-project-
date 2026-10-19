---
name: roblox-explorer-objects-and-properties
description: Referência prática em português sobre os objetos do Explorer do Roblox Studio, suas funções, propriedades, hierarquia, herança e uso seguro em Luau.
---

# Skill: Roblox Explorer — objetos, funções e propriedades

## Objetivo

Use esta skill para explicar, identificar, escolher, configurar e programar objetos que aparecem no **Explorer** do Roblox Studio. Ela deve ajudar a pessoa a entender:

- O que é cada objeto e para que serve.
- Em que parte da hierarquia ele costuma ficar.
- Quais propriedades são mais importantes e o que cada uma significa.
- Quais propriedades vêm de classes-pai e, por isso, aparecem em muitos objetos.
- Diferenças entre objetos parecidos.
- Como consultar a referência oficial quando uma classe ou propriedade não estiver descrita aqui.
- Como criar, encontrar, configurar e destruir objetos com Luau.

> **Importante sobre abrangência:** a API do Roblox muda continuamente e contém centenas de classes (mais de 600 na referência consultada). Não existe uma lista curta que descreva literalmente todas as classes, propriedades, métodos e eventos sem ficar enorme e rapidamente desatualizada. Esta skill cobre detalhadamente os objetos e as famílias mais usados no Explorer e define o procedimento obrigatório para documentar qualquer classe adicional sem inventar propriedades. A referência oficial ligada ao final é a fonte definitiva para a lista integral e atualizada.

## 1. O que é o Explorer

O **Explorer** é o painel do Studio que mostra a hierarquia de objetos do jogo. Cada item é, em geral, uma `Instance`. A hierarquia é formada por relações de pai e filho:

```text
game (DataModel)
├─ Workspace
│  ├─ Camera
│  ├─ Terrain
│  └─ Map (Model)
│     └─ Part
├─ ReplicatedStorage
│  ├─ RemoteEvent
│  └─ SharedModule (ModuleScript)
├─ ServerScriptService
│  └─ ServerMain (Script)
├─ StarterGui
│  └─ MainGui (ScreenGui)
│     └─ MainFrame (Frame)
│        └─ CloseButton (TextButton)
└─ StarterPlayer
   ├─ StarterPlayerScripts
   └─ StarterCharacterScripts
```

O nome exato, a quantidade e a disponibilidade dos objetos podem variar de um projeto para outro. Serviços podem ser obtidos com `game:GetService("NomeDoServico")`; não se deve presumir que todo objeto visível no Explorer está disponível para todos os scripts.

### Conceitos fundamentais

- **Instance:** objeto da hierarquia do DataModel.
- **ClassName:** nome da classe real do objeto, por exemplo `"Part"` ou `"TextButton"`. É somente leitura.
- **Name:** nome usado para identificar o objeto na hierarquia; normalmente pode ser alterado.
- **Parent:** objeto que contém o objeto atual. `Parent = nil` remove o objeto da hierarquia, mas não equivale necessariamente a chamar `Destroy()`.
- **Filho (child):** objeto diretamente dentro de outro.
- **Descendente (descendant):** filho, neto e qualquer objeto mais profundo na hierarquia.
- **Propriedade (property):** dado configurável de um objeto, como `Size`, `Position` ou `Text`.
- **Método (method):** função fornecida por uma classe, como `Destroy()`, `Clone()` ou `PivotTo()`.
- **Evento (event):** sinal que pode ser conectado a uma função, como `Touched` ou `Activated`.
- **Herança:** classes especializadas recebem propriedades e métodos das classes-pai. Por exemplo, `TextButton` herda propriedades de `GuiButton`, `GuiObject`, `GuiBase2d` e `Instance`.

## 2. Propriedades comuns a quase todos os objetos

A classe-base `Instance` fornece várias propriedades e métodos. Algumas propriedades podem estar ocultas, ser somente leitura, estar depreciadas ou ter restrições de segurança.

| Propriedade | Significado |
|---|---|
| `Name` | Nome do objeto na hierarquia. |
| `Parent` | Pai atual do objeto. |
| `ClassName` | Nome da classe exata; somente leitura. |
| `Archivable` | Controla se o objeto pode ser incluído em operações de clonagem. |
| `UniqueId` | Identificador interno; não é normalmente necessário em scripts comuns. |
| `Attributes` | Conjunto de atributos personalizados, acessados principalmente por métodos como `GetAttribute()` e `SetAttribute()`. |
| `Tags` | Tags gerenciadas pelo `CollectionService`; não são uma propriedade comum editada como `Name`. |

### Métodos comuns de `Instance`

| Método | Função |
|---|---|
| `GetChildren()` | Retorna uma tabela com os filhos diretos. |
| `GetDescendants()` | Retorna descendentes em todos os níveis. |
| `FindFirstChild(name, recursive?)` | Procura um filho pelo nome; opcionalmente percorre descendentes. |
| `FindFirstChildOfClass(className)` | Procura um filho direto da classe indicada. |
| `FindFirstChildWhichIsA(className, recursive?)` | Procura um objeto que seja daquela classe ou de uma classe derivada. |
| `WaitForChild(name, timeout?)` | Aguarda um filho aparecer, opcionalmente com limite de tempo. |
| `IsA(className)` | Verifica se o objeto pertence à classe ou a uma classe derivada. |
| `Clone()` | Cria uma cópia clonável do objeto e de seus descendentes. |
| `Destroy()` | Desconecta o objeto da hierarquia e destrói suas conexões/descendentes conforme o comportamento da API. |
| `ClearAllChildren()` | Destrói os filhos diretos e seus conteúdos descendentes. |
| `GetAttribute(name)` | Lê um atributo. |
| `SetAttribute(name, value)` | Define ou atualiza um atributo. |
| `GetAttributes()` | Retorna os atributos como tabela. |
| `GetFullName()` | Retorna o caminho hierárquico do objeto. |
| `GetPropertyChangedSignal(property)` | Retorna um sinal para mudanças de uma propriedade específica. |

Exemplo seguro:

```lua
local part = workspace:FindFirstChild("Platform")

if part and part:IsA("BasePart") then
    print("Classe:", part.ClassName)
    print("Nome:", part.Name)
    print("Tamanho:", part.Size)
end
```

Não se deve tentar escrever em propriedades somente leitura, ocultas ou protegidas. Verifique a referência da classe antes de usar uma propriedade em um script.

## 3. Serviços principais do Explorer

Serviços são objetos especiais obtidos normalmente com `game:GetService()`. Muitos não podem ser criados com `Instance.new()`.

### Estrutura, mundo e conteúdo

| Serviço/objeto | Função |
|---|---|
| `game` / `DataModel` | Raiz do jogo; permite acessar serviços e informações do lugar/servidor. |
| `Workspace` | Mundo 3D ativo: peças, modelos, personagens, câmera e terreno. |
| `Players` | Gerencia jogadores conectados e eventos de entrada/saída. |
| `Lighting` | Iluminação global, atmosfera e efeitos visuais globais. |
| `ReplicatedStorage` | Armazenamento replicado para servidor e clientes; usado para módulos compartilhados, assets e remotes. |
| `ReplicatedFirst` | Conteúdo replicado cedo ao cliente, frequentemente usado em telas de carregamento. |
| `ServerStorage` | Conteúdo acessível ao servidor e não replicado normalmente aos clientes. |
| `ServerScriptService` | Local recomendado para scripts do servidor. |
| `StarterGui` | Modelos de interfaces copiados para `PlayerGui` dos jogadores. |
| `StarterPack` | Ferramentas copiadas para a mochila do jogador ao entrar/respawn, conforme o fluxo do jogo. |
| `StarterPlayer` | Configurações e contêineres iniciais dos scripts do jogador/personagem. |
| `StarterPlayerScripts` | Scripts locais iniciais do jogador, dentro de `StarterPlayer`. |
| `StarterCharacterScripts` | Scripts copiados para cada personagem do jogador. |
| `SoundService` | Configurações e objetos relacionados ao áudio. |
| `TextChatService` | Sistema de chat de texto moderno e sua configuração. |
| `Teams` | Equipes do jogo. |
| `MaterialService` | Configurações de materiais e variantes de material. |
| `CollectionService` | API para organizar objetos por tags. |
| `TweenService` | Cria animações suaves de propriedades. |
| `RunService` | Eventos e informações sobre etapas do ciclo de execução; ajuda a distinguir cliente e servidor. |
| `UserInputService` | Entrada de teclado, mouse, toque e outros dispositivos no cliente. |
| `ContextActionService` | Vincula ações a controles e pode criar botões de toque. |
| `GuiService` | Informações e utilitários relacionados à interface. |
| `HttpService` | Codificação JSON e recursos HTTP permitidos conforme configuração e ambiente. |
| `MarketplaceService` | Compras e informações de produtos/passes dentro das regras da plataforma. |
| `DataStoreService` | Armazenamento persistente de dados no servidor, sujeito a permissões e limites. |
| `MemoryStoreService` | Dados temporários compartilhados entre servidores, sujeitos a limites. |
| `MessagingService` | Mensagens entre servidores de uma experiência, sujeito a limites. |
| `TeleportService` | Teleporte entre lugares/servidores, sujeito às regras da plataforma. |
| `PathfindingService` | Calcula caminhos para movimentação de NPCs. |
| `PhysicsService` | Configuração de grupos de colisão e comportamentos relacionados à física. |
| `Debris` | Agenda a remoção de objetos após um tempo. |
| `LocalizationService` | Recursos de localização/tradução. |
| `BadgeService` | Concede e consulta badges conforme permissões. |
| `AvatarEditorService` | Recursos de edição de avatar suportados. |
| `InsertService` | Recursos de inserção de assets sujeitos a permissões; não é um método genérico para carregar qualquer asset. |
| `AssetService` | Recursos para criar/gerenciar determinados assets e conteúdo. |
| `AnalyticsService` | Métricas e eventos analíticos. |
| `PolicyService` | Consulta políticas aplicáveis a recursos da experiência. |
| `VoiceChatService` | Configurações/recursos relacionados a voz, conforme elegibilidade e disponibilidade. |

**Atenção:** essa é uma seleção dos serviços mais conhecidos, não a lista integral de serviços da engine. Para a lista completa, abra o catálogo oficial de classes e filtre por classes terminadas em `Service`.

### Onde colocar scripts

| Local | Uso habitual |
|---|---|
| `ServerScriptService` | Lógica confiável do servidor: regras, validação, estado compartilhado e operações persistentes. |
| `ServerStorage` | Modelos e módulos que só o servidor deve acessar. |
| `ReplicatedStorage` | Módulos compartilhados e objetos de comunicação que cliente e servidor precisam referenciar. Não coloque segredos aqui. |
| `StarterPlayerScripts` | Controles e lógica local que deve continuar entre respawns. |
| `StarterCharacterScripts` | Lógica local associada a cada personagem/respawn. |
| `StarterGui` | Modelos de interface; scripts locais podem ficar dentro da interface ou em locais adequados do jogador. |
| `Workspace` | Scripts dentro de objetos do mundo podem ser apropriados em casos específicos, mas evite misturar lógica importante do servidor ao cenário sem necessidade. |

## 4. Objetos físicos e do mundo 3D

### `BasePart` — propriedades herdadas por peças físicas

`BasePart` é a classe-pai de muitos objetos físicos, como `Part`, `MeshPart`, `WedgePart`, `TrussPart` e `VehicleSeat`.

| Propriedade | Função |
|---|---|
| `Anchored` | Se `true`, a peça não é movida pela simulação física comum. |
| `CanCollide` | Define se a peça participa de colisões físicas. |
| `CanTouch` | Controla se eventos de toque podem ser disparados por contatos com a peça. |
| `CanQuery` | Controla se a peça pode ser encontrada por consultas espaciais, como raycasts/overlaps. |
| `Position` | Posição no mundo. |
| `CFrame` | Posição e orientação combinadas. |
| `Orientation` | Orientação em graus; para transformações complexas, `CFrame` costuma ser mais completo. |
| `Size` | Dimensões da peça. |
| `Color` | Cor da peça. |
| `BrickColor` | Sistema de cor legado do Roblox. |
| `Material` | Material visual/físico, por exemplo `Plastic`, `Metal`, `Wood` ou `Grass`. |
| `Transparency` | Transparência de `0` (opaco) a `1` (invisível). |
| `Reflectance` | Intensidade de reflexão legada. |
| `CastShadow` | Se a peça projeta sombra. |
| `Massless` | Se a peça é tratada como sem massa em certas situações físicas. |
| `CollisionGroup` | Grupo de colisão da peça. |
| `CustomPhysicalProperties` | Permite ajustar densidade, atrito, elasticidade e pesos relacionados. |
| `AssemblyLinearVelocity` | Velocidade linear do conjunto físico. |
| `AssemblyAngularVelocity` | Velocidade angular do conjunto físico. |
| `RootPriority` | Prioridade usada em determinadas decisões sobre a peça raiz do conjunto. |
| `Locked` | Impede seleção/edição direta no Studio; não é uma barreira de segurança em runtime. |
| `LocalTransparencyModifier` | Modificador de transparência local, normalmente usado para efeitos visuais no cliente. |
| `CurrentPhysicalProperties` | Propriedades físicas efetivas; leitura conforme API. |

### Classes físicas comuns

- **`Part`:** peça primitiva; `Shape` pode definir bloco, bola ou cilindro. Para formas em cunha, há classes específicas.
- **`MeshPart`:** malha 3D importada; propriedades incluem conteúdo da malha, textura, renderização e colisão. As propriedades exatas dependem da API atual.
- **`WedgePart`:** peça em forma de cunha.
- **`CornerWedgePart`:** cunha com canto inclinado.
- **`TrussPart`:** estrutura treliçada tradicional, frequentemente usada para escalar.
- **`UnionOperation` / `PartOperation`:** resultado de operações de modelagem sólida; algumas propriedades diferem de `Part`.
- **`Terrain`:** terreno voxelado do mundo; não se comporta como uma `Part` comum.
- **`Model`:** contêiner para agrupar objetos 3D. Propriedades/métodos importantes: `PrimaryPart` (opcional), `WorldPivot`, `GetPivot()`, `PivotTo(cframe)`, `GetBoundingBox()`. `Model` não é uma peça física única.
- **`Folder`:** contêiner organizacional sem comportamento visual próprio.
- **`Attachment`:** ponto de referência local usado por constraints, partículas, beams, trails e outros sistemas.
- **`Bone`:** ponto hierárquico usado para deformação de malhas/rigs.
- **`SpawnLocation`:** ponto de spawn de jogadores, com configurações como `Neutral`, `TeamColor`, `AllowTeamChangeOnTouch` e propriedades herdadas de `BasePart`.
- **`Seat`:** assento simples que pode sentar um humanoide.
- **`VehicleSeat`:** assento com entrada de condução de veículo.
- **`TrussPart`:** peça escalável.
- **`Decal`:** imagem aplicada a uma face de uma peça.
- **`Texture`:** textura repetida numa superfície; propriedades comuns incluem `Texture`, `Face`, `StudsPerTileU` e `StudsPerTileV`.
- **`SurfaceAppearance`:** mapas PBR de aparência de malha, como cor, normal, roughness e metalness, quando suportados.
- **`Highlight`:** destaca contorno e preenchimento de um objeto/modelo.
- **`BillboardGui`:** interface que fica voltada para a câmera e associada a um objeto do mundo.
- **`SurfaceGui`:** interface desenhada na superfície de uma peça.
- **`ClickDetector`:** detecta cliques/toques compatíveis em objetos 3D; para interação moderna, considere `ProximityPrompt` quando fizer sentido.
- **`ProximityPrompt`:** apresenta uma interação contextual ao jogador próximo; propriedades importantes incluem `ActionText`, `ObjectText`, `KeyboardKeyCode`, `HoldDuration`, `MaxActivationDistance`, `RequiresLineOfSight` e `Enabled`.
- **`Explosion`:** efeito de explosão com parâmetros de alcance/pressão; use com cuidado para não aplicar forças ou dano inesperado.
- **`ParticleEmitter`:** emite partículas a partir de um `Attachment` ou peça. Propriedades comuns: `Enabled`, `Rate`, `Lifetime`, `Speed`, `SpreadAngle`, `Size`, `Transparency`, `Color`, `Texture`, `LightEmission`, `RotSpeed` e `Acceleration`.
- **`Beam`:** desenha um feixe entre dois `Attachment`; propriedades incluem `Attachment0`, `Attachment1`, `Width0`, `Width1`, `Color`, `Transparency`, `Texture` e `Enabled`.
- **`Trail`:** deixa rastro entre attachments; usa propriedades de cor, transparência, largura, duração e `Enabled`.
- **`Fire`, `Smoke`, `Sparkles`:** efeitos legados; para efeitos novos, avalie `ParticleEmitter` e sistemas atuais.
- **`PointLight`:** luz em todas as direções a partir de uma posição.
- **`SpotLight`:** luz direcional em cone.
- **`SurfaceLight`:** luz emitida a partir de uma face.
- **`Attachment` + constraints:** permitem posicionar e orientar constraints de forma controlada.

### Propriedades de `Model` versus `BasePart`

Um `Model` agrupa peças; não possui `Size`, `Color` ou `Anchored` como uma peça individual. Para mover um modelo inteiro, use `PivotTo()` ou ajuste seu pivot. Para mover uma peça individual, use `CFrame`/`Position` quando apropriado.

## 5. Juntas, constraints e física

As constraints conectam peças ou aplicam forças/orientações. Normalmente usam `Attachment0` e `Attachment1`.

| Classe | Função |
|---|---|
| `WeldConstraint` | Mantém duas peças rigidamente unidas. |
| `Weld` | Junta legada por offsets relativos. |
| `Motor6D` | Junta articulada usada com frequência em rigs de personagens e animação. |
| `HingeConstraint` | Permite rotação em torno de um eixo. |
| `BallSocketConstraint` | Permite rotação em várias direções, como uma junta esférica. |
| `RopeConstraint` | Mantém uma distância máxima, como uma corda. |
| `RodConstraint` | Mantém distância fixa entre attachments. |
| `SpringConstraint` | Comportamento de mola. |
| `PrismaticConstraint` | Movimento linear ao longo de um eixo. |
| `CylindricalConstraint` | Combina movimento linear e rotação em torno de um eixo. |
| `AlignPosition` | Aplica força para alinhar posições. |
| `AlignOrientation` | Aplica força/torque para alinhar orientações. |
| `LinearVelocity` | Controla a velocidade linear por constraint. |
| `AngularVelocity` | Controla velocidade angular. |
| `VectorForce` | Aplica uma força vetorial. |
| `Torque` | Aplica torque. |
| `NoCollisionConstraint` | Impede colisão entre duas peças específicas. |
| `RigidConstraint` | Liga rigidamente attachments. |
| `PlaneConstraint` | Restringe movimento a um plano. |
| `LineForce` | Força ao longo de uma linha definida por attachments. |
| `PathfindingLink` | Define uma ligação especial para pathfinding de NPCs. |
| `PathfindingModifier` | Modifica como uma região é considerada pelo pathfinding. |

**Propriedades comuns:** `Enabled`, `Attachment0`, `Attachment1`, limites, força/torque máximos, modo de reação e parâmetros específicos de cada classe. Nem todas as constraints usam todos esses campos. Consulte a página da classe antes de copiar propriedades de outra constraint.

> As classes antigas `BodyVelocity`, `BodyPosition`, `BodyGyro`, `BodyForce`, `BodyAngularVelocity` e `BodyThrust` são legadas/depreciadas em muitos fluxos. Para sistemas novos, avalie as constraints modernas adequadas.

## 6. Personagens, jogadores e itens

### `Players` e `Player`

- **`Players`:** serviço que administra jogadores.
- **`Player`:** representa um jogador conectado; não é o personagem 3D.
- **`Player.Character`:** modelo do avatar atual.
- **`Player.PlayerGui`:** interfaces ativas daquele jogador.
- **`Player.Backpack`:** ferramentas carregáveis do jogador.
- **`Player.PlayerScripts`:** scripts locais do jogador.
- **`Player.UserId`:** identificador numérico do usuário.
- **`Player.DisplayName`:** nome de exibição.
- **`Player.Name`:** nome de conta usado pelo objeto.
- **`Player.Team` / `TeamColor`:** equipe/cor de equipe quando usada.
- **`Player.CharacterAdded`:** evento disparado quando um personagem aparece.
- **`Player.CharacterRemoving`:** evento relacionado à remoção do personagem.

Não confunda `Player` com `Character`: `Player` é a identidade da sessão; `Character` é o modelo físico atual.

### `Humanoid`

Controla comportamentos comuns de um personagem, incluindo estados, vida e movimento.

| Propriedade | Significado |
|---|---|
| `Health` | Vida atual. |
| `MaxHealth` | Vida máxima. |
| `WalkSpeed` | Velocidade de caminhada configurada. |
| `JumpPower` | Potência de salto quando o modo correspondente está habilitado. |
| `JumpHeight` | Altura de salto quando o modo correspondente está habilitado. |
| `UseJumpPower` | Decide se o sistema usa `JumpPower` ou `JumpHeight`. |
| `HipHeight` | Ajuste de altura do humanoide em relação ao chão. |
| `RigType` | Tipo de rig, como R6 ou R15. |
| `DisplayName` | Nome exibido acima do personagem, conforme configuração. |
| `DisplayDistanceType` | Controla a distância de exibição do nome/vida. |
| `NameDisplayDistance` | Distância de exibição do nome. |
| `HealthDisplayDistance` | Distância de exibição da barra de vida. |
| `AutoRotate` | Permite rotação automática na direção do movimento. |
| `Sit` | Estado de sentado quando aplicável. |
| `PlatformStand` | Coloca o humanoide em estado sem controle normal. |
| `BreakJointsOnDeath` | Controla se juntas são quebradas ao morrer. |
| `RequiresNeck` | Configuração relativa ao pescoço do rig. |
| `StateEnabled` | Estados são controlados por métodos como `SetStateEnabled`, não por uma propriedade simples universal. |

Eventos e métodos úteis: `Died`, `Running`, `MoveTo()`, `ChangeState()`, `GetState()`, `TakeDamage()` e `EquipTool()` (consulte a API para assinatura e contexto).

### Outros objetos de personagem

- **`Animator`:** carrega e reproduz animações por `AnimationTrack`.
- **`Animation`:** referencia o asset de animação.
- **`AnimationTrack`:** reprodução em runtime; métodos como `Play()`, `Stop()` e `AdjustSpeed()`.
- **`HumanoidDescription`:** descreve aparência e acessórios de um avatar.
- **`Accessory`:** acessório equipado no personagem.
- **`Shirt`, `Pants`, `ShirtGraphic`:** roupas clássicas.
- **`BodyColors`:** cores de partes do corpo em rigs compatíveis.
- **`Tool`:** item que pode ser equipado; frequentemente contém `Handle`, scripts e attachments. Propriedades comuns incluem `Enabled`, `CanBeDropped`, `RequiresHandle` e `ToolTip`.
- **`Backpack`:** contêiner de ferramentas do jogador.
- **`ForceField`:** proteção de personagem conforme regras do jogo.
- **`Team`:** define uma equipe; propriedades incluem `Name`, `TeamColor`, `AutoAssignable` e `Score` quando aplicável.

## 7. Scripts e comunicação

### `Script`, `LocalScript` e `ModuleScript`

| Classe | Execução/uso | Observações |
|---|---|---|
| `Script` | Lógica do servidor em locais apropriados, ou conforme `RunContext` atual. | Use para regras confiáveis e validação. |
| `LocalScript` | Lógica local do cliente em contêineres suportados. | Não deve ser fonte de autoridade para moedas, inventário ou resultados importantes. |
| `ModuleScript` | Código reutilizável importado com `require()`. | Retorna um valor, geralmente uma tabela com funções. Executa no contexto de quem o requer. |

Propriedades relevantes de scripts podem incluir `Enabled`, `RunContext` (para classes que o suportam), `LinkedSource`/metadados específicos do editor e `Source` com restrições de segurança. Nem toda propriedade de código pode ser lida ou escrita por qualquer script/runtime. Não prometa que um script em runtime pode inspecionar ou alterar o código-fonte de outro script.

### Comunicação entre cliente e servidor

- **`RemoteEvent`:** comunicação assíncrona de uma direção por chamada (`FireServer`, `FireClient`, `FireAllClients`).
- **`RemoteFunction`:** chamada com retorno (`InvokeServer`, `InvokeClient`); pode ceder a execução enquanto espera.
- **`BindableEvent`:** evento local dentro do mesmo contexto de execução, sem atravessar automaticamente cliente/servidor.
- **`BindableFunction`:** função local com retorno, sem comunicação de rede.
- **`UnreliableRemoteEvent`:** comunicação remota sem garantia de entrega/ordem, útil para dados frequentes não críticos quando apropriado.

**Segurança obrigatória:** qualquer dado recebido do cliente é não confiável. O servidor deve validar tipos, limites, propriedade do objeto, distância, permissões, frequência de chamadas e estado atual antes de aceitar uma solicitação. Não coloque chaves secretas ou autoridade de dados em `ReplicatedStorage`.

### Valores e configurações

| Classe | Tipo armazenado |
|---|---|
| `BoolValue` | Booleano (`true`/`false`). |
| `StringValue` | Texto. |
| `NumberValue` | Número de ponto flutuante. |
| `IntValue` | Inteiro. |
| `ObjectValue` | Referência a outro objeto. |
| `Vector3Value` | `Vector3`. |
| `Vector2Value` | `Vector2`. |
| `CFrameValue` | `CFrame`. |
| `Color3Value` | `Color3`. |
| `BrickColorValue` | `BrickColor`. |
| `RayValue` | `Ray` (legado/especializado). |
| `NumberValue` e outros `ValueBase` | Cada classe define seu tipo e propriedade `Value`. |

Esses objetos podem ser úteis para valores simples visíveis na hierarquia, mas não substituem automaticamente tabelas, atributos, módulos ou sistemas de dados bem estruturados. Para dados persistentes, use um sistema no servidor apropriado; um `ValueObject` por si só não salva progresso entre sessões.

### `Configuration` e `Folder`

- **`Folder`:** agrupa objetos sem lógica própria.
- **`Configuration`:** contêiner para organizar configurações/valores relacionados; não aplica automaticamente qualquer regra de jogo.

### `Actor` e execução paralela

`Actor` agrupa scripts e objetos para certos fluxos de execução paralela. Só use APIs de execução paralela e mensagens entre Actors quando entender as restrições de thread-safety e o modelo atual.

## 8. Interface (GUI) no Explorer

A interface padrão costuma estar em `StarterGui` e é copiada para `PlayerGui` quando o jogador entra. Os objetos visuais descendem de famílias como `GuiBase2d`, `GuiObject`, `GuiButton`, `GuiLabel` e `LayerCollector`.

### Contêineres de interface

- **`ScreenGui`:** desenha UI na tela do jogador.
- **`BillboardGui`:** interface que acompanha um objeto/attachment no mundo e encara a câmera.
- **`SurfaceGui`:** desenha UI sobre uma face de uma peça.
- **`Frame`:** contêiner visual retangular.
- **`ScrollingFrame`:** contêiner com rolagem.
- **`CanvasGroup`:** agrupa elementos para efeitos como transparência de grupo e composição.
- **`ViewportFrame`:** renderiza um mundo 3D dentro da interface.
- **`GuiButton`:** classe-pai de botões.
- **`GuiObject`:** classe-pai de muitos elementos visuais 2D.
- **`LayerCollector`:** classe-pai de coletores de interface, incluindo `ScreenGui`, `BillboardGui` e `SurfaceGui`.

### Elementos visuais e de entrada

| Classe | Função |
|---|---|
| `TextLabel` | Mostra texto, sem comportamento de botão. |
| `TextButton` | Texto clicável/interativo. |
| `TextBox` | Campo para digitação. |
| `ImageLabel` | Mostra uma imagem. |
| `ImageButton` | Imagem clicável. |
| `VideoFrame` | Exibe vídeo quando o recurso está disponível. |
| `ViewportFrame` | Renderiza objetos 3D em uma área da GUI. |
| `CanvasGroup` | Agrupa GUI para composição/transparência. |
| `ScrollingFrame` | Área rolável. |
| `UIListLayout` | Organiza filhos em lista horizontal ou vertical. |
| `UIGridLayout` | Organiza filhos em grade. |
| `UITableLayout` | Organiza filhos em formato tabular. |
| `UIPageLayout` | Organiza páginas e navegação entre elas. |
| `UIPadding` | Adiciona margens internas. |
| `UICorner` | Arredonda cantos de objetos compatíveis. |
| `UIStroke` | Contorno visual. |
| `UIGradient` | Gradiente de cor/transparência. |
| `UIScale` | Escala visual de um objeto GUI e seus descendentes. |
| `UISizeConstraint` | Restringe tamanho mínimo/máximo. |
| `UIAspectRatioConstraint` | Mantém proporção de aspecto. |
| `UIFlexItem` | Controla comportamento flexível em layouts compatíveis. |
| `UITextSizeConstraint` | Restringe tamanho de texto quando suportado. |
| `UIComponent` / componentes atuais | Consulte API atual, pois o conjunto de componentes pode evoluir. |
| `UICheckbox` ou controles especializados | Confirme a disponibilidade na versão atual; não presuma que todo controle comum de outras plataformas exista como classe nativa. |

### Propriedades comuns de `GuiObject`

| Propriedade | Função |
|---|---|
| `AnchorPoint` | Ponto de ancoragem relativo ao próprio objeto, em geral entre 0 e 1. |
| `Position` | Posição relativa ao pai, usando `UDim2`. |
| `Size` | Tamanho relativo/absoluto, usando `UDim2`. |
| `SizeConstraint` | Define a dimensão usada por certas regras de tamanho. |
| `AutomaticSize` | Pode ajustar o tamanho ao conteúdo, conforme direção escolhida. |
| `BackgroundColor3` | Cor do fundo. |
| `BackgroundTransparency` | Transparência do fundo, de 0 a 1. |
| `BorderColor3` | Cor da borda clássica, quando aplicável. |
| `BorderSizePixel` | Espessura clássica da borda. |
| `Visible` | Controla se o objeto é exibido. |
| `ZIndex` | Ordem de sobreposição entre elementos GUI. |
| `LayoutOrder` | Ordem usada por layouts que respeitam essa propriedade. |
| `ClipsDescendants` | Recorta descendentes aos limites do contêiner, quando aplicável. |
| `Rotation` | Rotação 2D em graus. |
| `Selectable` | Participação em seleção/navegação por controles compatíveis. |
| `Active` | Controla certas interações/entrada do objeto; o efeito depende da classe. |
| `Interactable` | Controla se o objeto pode ser interagido, quando suportado. |
| `SelectionGroup` | Configuração de navegação/seleção em sistemas compatíveis. |
| `InputBegan`, `InputChanged`, `InputEnded` | Eventos de entrada associados ao objeto, conforme suporte. |
| `AbsolutePosition` | Posição final em pixels; leitura somente. |
| `AbsoluteSize` | Tamanho final em pixels; leitura somente. |
| `AbsoluteRotation` | Rotação absoluta; leitura somente. |
| `MouseEnter`, `MouseLeave` | Eventos relacionados ao mouse, em objetos compatíveis. |

### Propriedades de texto

`TextLabel`, `TextButton` e `TextBox` compartilham muitas propriedades por herança.

| Propriedade | Função |
|---|---|
| `Text` | Conteúdo textual. |
| `Font` / `FontFace` | Fonte usada; prefira verificar as propriedades atuais de fonte na API. |
| `TextColor3` | Cor do texto. |
| `TextTransparency` | Transparência do texto. |
| `TextSize` | Tamanho do texto em pixels. |
| `TextScaled` | Escala o texto para caber; use com cuidado em layouts responsivos. |
| `TextWrapped` | Permite quebra de linha. |
| `TextXAlignment` | Alinhamento horizontal. |
| `TextYAlignment` | Alinhamento vertical. |
| `TextTruncate` | Controla truncamento em situações suportadas. |
| `RichText` | Habilita formatação com marcação RichText suportada. |
| `LineHeight` | Altura relativa das linhas, quando suportada. |
| `MaxVisibleGraphemes` | Limita os caracteres visíveis para efeitos de digitação. |
| `TextBounds` | Tamanho medido do texto; leitura somente/legada conforme API. |
| `TextFits` | Indica se o texto cabe; verifique o status atual dessa propriedade. |

Propriedades adicionais de `TextBox` podem incluir `PlaceholderText`, `PlaceholderColor3`, `ClearTextOnFocus`, `MultiLine`, `TextEditable`, `CursorPosition`, `SelectionStart` e `TextXAlignment`. Use `Text` para ler o conteúdo e eventos como `Focused`, `FocusLost` e `ReturnPressedFromOnScreenKeyboard` quando suportados.

### Propriedades de botões

`TextButton` e `ImageButton` herdam propriedades de `GuiButton`, como `Activated`, `MouseButton1Click` (legado/menos recomendado em muitos casos), `AutoButtonColor`, `Selected` e `Modal` conforme a classe/API. Para interação moderna multiplataforma, normalmente prefira `Activated`, que funciona com mouse, toque e controles compatíveis.

### Propriedades de `ScreenGui`

Algumas das propriedades mais relevantes:

- `Enabled`: liga/desliga a interface.
- `DisplayOrder`: ordem da camada da GUI em relação a outras `ScreenGui`.
- `IgnoreGuiInset`: controla como a GUI considera os insets da interface do Roblox; entenda o comportamento atual antes de usar.
- `ResetOnSpawn`: define se a GUI é reiniciada quando o personagem reaparece.
- `ZIndexBehavior`: define como a ordem de ZIndex é interpretada.
- `ScreenInsets` e `SafeAreaCompatibility`: configurações de área segura/insets conforme API atual.
- `ClipToDeviceSafeArea`: controla recorte para a área segura, quando disponível.

### Propriedades de `ScrollingFrame`

- `CanvasSize`: tamanho total da área rolável.
- `CanvasPosition`: posição atual da rolagem.
- `AutomaticCanvasSize`: permite que o canvas cresça conforme conteúdo em direções configuradas.
- `ScrollingDirection`: direção permitida de rolagem.
- `ScrollBarThickness`: espessura da barra.
- `ScrollBarImageColor3` / `ScrollBarImageTransparency`: aparência da barra.
- `ScrollingEnabled`: habilita/desabilita rolagem.
- `ElasticBehavior`: comportamento elástico quando suportado.
- `VerticalScrollBarPosition`: posição da barra vertical quando aplicável.

### Propriedades de imagem

`ImageLabel` e `ImageButton` podem usar propriedades como `Image`, `ImageColor3`, `ImageTransparency`, `ScaleType`, `SliceCenter`, `SliceScale`, `TileSize`, `ResampleMode` e `ImageRectOffset`/`ImageRectSize` conforme o recurso. Os nomes de assets e permissões devem respeitar as regras do Roblox.

### Layouts e modificadores de UI

- **`UIListLayout`:** `FillDirection`, `HorizontalAlignment`, `VerticalAlignment`, `Padding`, `SortOrder`, `Wraps` (conforme suporte).
- **`UIGridLayout`:** `CellSize`, `CellPadding`, `FillDirection`, `FillDirectionMaxCells`, `SortOrder`, alinhamentos.
- **`UITableLayout`:** propriedades de preenchimento, ordenação e dimensionamento de colunas/linhas.
- **`UIPageLayout`:** configurações de alinhamento, direção, duração de tween e navegação de páginas.
- **`UIPadding`:** `PaddingTop`, `PaddingBottom`, `PaddingLeft`, `PaddingRight`.
- **`UICorner`:** `CornerRadius`.
- **`UIStroke`:** `Color`, `Thickness`, `Transparency`, `ApplyStrokeMode`, `LineJoinMode` conforme a API.
- **`UIGradient`:** `Color`, `Transparency`, `Rotation`, `Offset`, `Enabled`.
- **`UIScale`:** `Scale`.
- **`UISizeConstraint`:** `MinSize`, `MaxSize`.
- **`UIAspectRatioConstraint`:** `AspectRatio`, `AspectType`, `DominantAxis`.
- **`UITextSizeConstraint`:** limites mínimo e máximo do texto, quando suportado.

Não aplique propriedades de um modificador a outro. Cada objeto `UI*` tem um conjunto próprio.

## 9. Câmera, ambiente e efeitos

- **`Camera`:** controla a visão do mundo; propriedades comuns incluem `CFrame`, `Focus`, `FieldOfView`, `CameraType`, `ViewportSize` e `CameraSubject`. Algumas propriedades são leitura somente ou controladas pelo cliente.
- **`Lighting`:** controla hora do dia, brilho, ambiente, sombras e efeitos globais.
- **`Atmosphere`:** haze, densidade, brilho e cor atmosférica.
- **`Sky`:** imagens de céu.
- **`BloomEffect`:** brilho de áreas luminosas.
- **`BlurEffect`:** desfoque.
- **`ColorCorrectionEffect`:** ajuste de cor, contraste, saturação e brilho.
- **`DepthOfFieldEffect`:** profundidade de campo.
- **`SunRaysEffect`:** raios de sol.
- **`Clouds`:** nuvens no ambiente compatível.
- **`ColorGradingEffect`:** gradação de cor, conforme recurso atual.
- **`PostEffect`:** classe-pai de efeitos pós-processamento.

Efeitos de pós-processamento normalmente ficam em `Lighting` ou na câmera, conforme o tipo e o comportamento desejado. O suporte visual pode variar por dispositivo.

## 10. Áudio e vídeo

O sistema de áudio moderno possui classes como `AudioPlayer`, `AudioEmitter`, `AudioListener`, `AudioDeviceInput`, `AudioDeviceOutput`, `AudioAnalyzer`, `AudioEqualizer`, `AudioCompressor`, `AudioReverb`, `AudioEcho`, `AudioChorus`, `AudioDistortion`, `AudioPitchShifter`, `AudioFader`, `Wire` e mixers. A arquitetura de áudio pode ser baseada em grafo e não é igual ao sistema legado de `Sound`.

- **`Sound`:** objeto clássico para tocar áudio. Propriedades usuais: `SoundId`, `Volume`, `PlaybackSpeed`, `Looped`, `Playing`, `TimePosition`, `RollOffMode`, `RollOffMinDistance`, `RollOffMaxDistance`, `EmitterSize` e `SoundGroup`, conforme a classe/API.
- **`SoundGroup`:** agrupa sons para controlar volume/efeitos em conjunto.
- **`SoundEffect`:** classe-pai de efeitos legados de som, como `EqualizerSoundEffect`, `ReverbSoundEffect`, `EchoSoundEffect`, `CompressorSoundEffect`, `DistortionSoundEffect`, `ChorusSoundEffect` e `PitchShiftSoundEffect`.
- **`AudioPlayer`:** fonte de áudio do sistema moderno; confira propriedades e fluxo de carregamento atuais.
- **`AudioEmitter` / `AudioListener`:** definem emissor e ouvinte no sistema espacial.
- **`Wire`:** conecta nós compatíveis do sistema de áudio.
- **`VideoFrame`:** exibe vídeo em uma GUI; a disponibilidade e as restrições dependem do recurso atual.

Não presuma que todos os assets de áudio/vídeo podem ser reproduzidos por qualquer experiência. Permissões, moderação, disponibilidade do recurso e propriedade do asset importam.

## 11. Animações

- **`Animation`:** referência a um asset de animação.
- **`Animator`:** gerencia a reprodução de animações em um rig.
- **`AnimationTrack`:** controla uma animação carregada; pode ter `Length`, `IsPlaying`, `Looped`, `Priority`, `Speed` e `TimePosition` conforme a API.
- **`KeyframeSequence`, `Keyframe`, `Pose` e `KeyframeMarker`:** objetos usados em fluxos de edição/animação tradicionais.
- **`TweenService`:** anima propriedades comuns entre valores inicial e final; não substitui animações de rig.
- **`Tween`:** objeto de runtime criado por `TweenService:Create()`; métodos comuns incluem `Play()`, `Pause()`, `Cancel()` e evento `Completed`.

Use o sistema apropriado: `TweenService` para UI/valores; `Animator` para animação de personagem/rig.

## 12. Dados persistentes, temporários e mensagens entre servidores

- **`DataStoreService`:** armazenamento persistente para dados de uma experiência. As operações são normalmente feitas no servidor e podem falhar/ser limitadas; implemente `pcall`, tentativas cuidadosas e validação.
- **`GlobalDataStore`:** interface de armazenamento chave-valor obtida pelo serviço.
- **`OrderedDataStore`:** armazenamento ordenável, útil para rankings.
- **`MemoryStoreService`:** estruturas temporárias compartilhadas entre servidores, com expiração/limites.
- **`MemoryStoreQueue`:** fila temporária.
- **`MemoryStoreHashMap`:** mapa temporário chave-valor.
- **`MemoryStoreSortedMap`:** mapa temporário ordenado.
- **`MessagingService`:** publica/recebe mensagens entre servidores da mesma experiência dentro de limites.
- **`HttpService`:** serialização JSON, geração de GUID e HTTP permitido em contextos/configurações suportados.

Não use `DataStore` como um canal genérico para conversar diretamente com o criador do jogo. Dados só aparecem a quem tem permissões e código apropriados; objetos do Explorer não concedem automaticamente acesso a dados de outros jogos ou usuários. Nunca armazene senhas, tokens privados ou segredos em objetos replicados.

## 13. Caminhos, prompts e interação com o mundo

- **`ProximityPrompt`:** interação contextual a curta distância.
- **`ClickDetector`:** detecção de clique em objeto 3D.
- **`PathfindingService`:** calcula caminhos.
- **`PathfindingModifier`:** altera custo/consideração de região.
- **`PathfindingLink`:** conexão especial entre regiões para pathfinding.
- **`CollectionService`:** marca grupos de objetos com tags.
- **`Highlight`:** destaque visual de objeto/modelo.
- **`BillboardGui`:** rótulo ou barra que acompanha um objeto no mundo.
- **`Beam` / `Trail`:** efeitos visuais conectados a attachments.
- **`DragDetector`:** facilita arrastar objetos compatíveis com controles suportados; confira as propriedades e os limites atuais.
- **`UIDragDetector`:** permite interação de arrastar em interfaces GUI quando suportado.

## 14. Valores matemáticos comuns em propriedades

As propriedades usam tipos de dados, não apenas números simples. Entenda os mais frequentes:

| Tipo | O que representa | Exemplo de uso |
|---|---|---|
| `boolean` | Verdadeiro/falso. | `Anchored = true` |
| `string` | Texto. | `Name = "MainFrame"` |
| `number` | Número. | `Transparency = 0.25` |
| `Vector2` | X e Y. | `Vector2.new(100, 50)` |
| `Vector3` | X, Y e Z. | `Vector3.new(0, 5, 0)` |
| `CFrame` | Posição e orientação 3D. | `CFrame.new(0, 5, 0)` |
| `UDim` | Escala e offset em um eixo. | `UDim.new(0.5, 10)` |
| `UDim2` | Escala e offset em X e Y. | `UDim2.new(1, -20, 0, 50)` |
| `Color3` | Cor RGB. | `Color3.fromRGB(255, 255, 255)` |
| `BrickColor` | Cor do sistema legado. | `BrickColor.new("Bright blue")` |
| `Enum` | Conjunto fechado de opções. | `Enum.Material.Metal` |
| `NumberSequence` | Valores variáveis ao longo de uma faixa. | Transparência/tamanho de partículas. |
| `ColorSequence` | Gradiente de cores. | Cor de partículas/gradiente. |
| `Instance` | Referência a outro objeto. | `PrimaryPart` ou `Attachment0`. |
| `PhysicalProperties` | Densidade, atrito e elasticidade. | Física personalizada. |

## 15. Como criar e configurar objetos com Luau

### Criar uma peça

```lua
local part = Instance.new("Part")
part.Name = "Platform"
part.Size = Vector3.new(12, 1, 12)
part.Position = Vector3.new(0, 5, 0)
part.Anchored = true
part.Material = Enum.Material.SmoothPlastic
part.Color = Color3.fromRGB(70, 140, 255)
part.Parent = workspace
```

Defina as propriedades antes de colocar o objeto na hierarquia sempre que isso ajudar a reduzir trabalho desnecessário de replicação/renderização.

### Criar uma GUI simples

```lua
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ExampleGui"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.fromOffset(320, 180)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Parent = screenGui

local button = Instance.new("TextButton")
button.Name = "CloseButton"
button.Text = "Fechar"
button.Size = UDim2.fromOffset(100, 36)
button.Position = UDim2.new(1, -110, 0, 10)
button.Parent = frame

button.Activated:Connect(function()
    screenGui.Enabled = false
end)

-- Em um LocalScript apropriado:
screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
```

Esse exemplo deve ser executado em um `LocalScript` num local apropriado do cliente. Não tente acessar `LocalPlayer` de um `Script` do servidor.

### Encontrar objetos com segurança

```lua
local replicatedStorage = game:GetService("ReplicatedStorage")
local module = replicatedStorage:WaitForChild("SharedModule", 5)

if module and module:IsA("ModuleScript") then
    local shared = require(module)
    print("Módulo carregado", shared)
else
    warn("SharedModule não encontrado ou classe incorreta")
end
```

### Clonar e destruir

```lua
local template = game:GetService("ServerStorage"):FindFirstChild("EnemyTemplate")

if template then
    local clone = template:Clone()
    clone.Parent = workspace
end

-- Para remover um objeto criado por seu próprio sistema:
-- clone:Destroy()
```

Evite destruir objetos de que outros scripts dependem sem coordenar o ciclo de vida.

## 16. Como explicar uma propriedade corretamente

Ao documentar uma propriedade, a skill deve usar este formato:

1. **Nome exato:** conforme API, respeitando maiúsculas/minúsculas.
2. **Tipo:** `boolean`, `number`, `string`, `Vector3`, `Enum.*`, `Instance`, etc.
3. **Leitura/escrita:** se é somente leitura, gravável ou restrita.
4. **Valor/intervalo:** explicar o intervalo real, se a API o define.
5. **Efeito:** o que muda no jogo/Studio.
6. **Contexto:** classes em que existe e herança da qual vem.
7. **Exemplo válido:** código pequeno com a propriedade em contexto.
8. **Limitações:** replicação, contexto cliente/servidor, estado depreciado ou plataforma.
9. **Fonte:** link direto da API oficial para a classe/propriedade.

Não invente propriedades por analogia. Se não souber se uma propriedade existe, consulte a API. Não trate propriedades somente leitura como editáveis. Não diga que uma propriedade aparece no painel Properties em todos os contextos: a visibilidade depende da classe, seleção e modo do Studio.

## 17. Como descobrir todos os objetos e propriedades

Para uma classe específica, abra a documentação oficial e consulte:

- **Properties:** todas as propriedades declaradas na classe.
- **Inherited Members:** propriedades/métodos/eventos herdados.
- **Methods:** funções disponíveis.
- **Events:** sinais emitidos.
- **Callbacks:** funções de retorno, quando houver.
- **Tags/Thread safety/Security:** restrições especiais.
- **Deprecated:** APIs antigas que não devem ser recomendadas sem motivo.
- **Code Samples:** exemplos de uso, quando disponíveis.

Use `Object:IsA("BasePart")` para testar herança. `ClassName == "Part"` verifica somente a classe exata e não inclui classes derivadas.

### Exemplo: listar classes/propriedades não é igual a modificar o Explorer

Um script de jogo pode inspecionar muitas instâncias acessíveis ao seu contexto, mas não pode usar a API normal para descobrir arbitrariamente todo o código-fonte, dados privados ou objetos de outros jogos. O Explorer do Studio também mostra elementos editoriais e serviços que não são equivalentes a objetos comuns criados em runtime.

## 18. Depreciação, contexto e segurança

- **Depreciado (`Deprecated`):** a API pode continuar existindo, mas há alternativa recomendada. Explique o status e não recomende em código novo sem motivo.
- **Somente leitura:** não atribua valores a essa propriedade.
- **Restrito por segurança:** pode não ser acessível por scripts comuns, principalmente em contexto de runtime.
- **Cliente versus servidor:** `LocalScript` e `Script` têm capacidades e locais de execução diferentes.
- **Replicação:** objetos e propriedades não necessariamente replicam nos dois sentidos.
- **Editor versus runtime:** certos objetos/configurações existem no Studio/editor e não no jogo publicado.
- **Permissões de assets:** um ID válido não garante que a experiência tenha permissão para usar o asset.
- **API em evolução:** confira a documentação atual quando houver dúvida.

## 19. Checklist de diagnóstico no Explorer

Quando um objeto não funciona, verifique:

1. A classe é a correta (`ClassName`)?
2. O `Parent` está correto?
3. O objeto está no local em que aquele tipo de script consegue acessá-lo?
4. O nome está escrito corretamente e sem espaços inesperados?
5. O objeto está habilitado/visível (`Enabled`, `Visible`) quando aplicável?
6. Há uma propriedade somente leitura ou restrita?
7. O objeto depende de outro objeto, attachment, PrimaryPart ou configuração?
8. O evento realmente dispara no contexto usado?
9. O código roda no cliente ou servidor correto?
10. A saída (`Output`) mostra erro?
11. A classe ou propriedade está depreciada?
12. O comportamento muda em mobile, console ou outro dispositivo?
13. A operação foi validada no servidor quando afeta dados importantes?

## 20. Fontes oficiais e tutoriais

Use sempre a documentação atual como referência final. A documentação de comunidades pode ajudar a entender um caso prático, mas pode usar APIs antigas.

- [Roblox Engine API — classes](https://create.roblox.com/docs/reference/engine/classes)
- [Classes do Roblox Engine em português](https://create.roblox.com/docs/pt-br/reference/engine/classes)
- [Referência de `Instance`](https://create.roblox.com/docs/reference/engine/classes/Instance)
- [Referência de `DataModel`](https://create.roblox.com/docs/reference/engine/classes/DataModel)
- [Data model — hierarquia do jogo](https://create.roblox.com/docs/projects/data-model)
- [Tipos de dados do Engine](https://create.roblox.com/docs/reference/engine/datatypes)
- [Enumeradores do Engine](https://create.roblox.com/docs/reference/engine/enums)
- [Serviços e execução cliente/servidor](https://create.roblox.com/docs/scripting)
- [Explorer no Studio](https://create.roblox.com/docs/studio/explorer)

## 21. Instruções para uma IA que use esta skill

Ao responder perguntas sobre o Explorer:

1. Responda em português claro, a menos que o usuário peça outro idioma.
2. Comece pela função principal do objeto e um exemplo simples.
3. Separe **propriedades**, **métodos** e **eventos** — não os misture.
4. Diga quais propriedades são herdadas e quais são específicas da classe.
5. Explique tipos como `UDim2`, `CFrame`, `Vector3` e `Enum` antes de usá-los se a pessoa for iniciante.
6. Dê exemplos Luau válidos para o contexto indicado.
7. Diferencie `Script`, `LocalScript` e `ModuleScript` sem dizer que são intercambiáveis.
8. Ao tratar dados ou remotes, priorize validação no servidor.
9. Se o usuário pedir “todas as propriedades” de uma classe, consulte a página oficial daquela classe e liste os nomes e significados com cuidado; inclua propriedades herdadas relevantes e indique as somente leitura/depreciadas.
10. Se o usuário pedir “todos os elementos do Explorer”, explique que a lista integral é muito grande e muda com o engine, então organize por famílias e use o catálogo oficial para classes restantes; nunca alegue que uma seleção parcial é literalmente cada classe existente.
11. Não invente propriedades, IDs de assets, permissões, APIs, resultados ou comportamentos.
12. Priorize mudanças pequenas e específicas quando o usuário estiver corrigindo um script existente.

## Resumo

O Explorer é uma hierarquia de `Instance`. Cada classe tem suas próprias propriedades, métodos e eventos, além dos membros herdados. Para entender um objeto, identifique sua classe, sua função, seu local, suas propriedades editáveis e seu contexto de execução. Esta skill cobre os objetos mais usados e ensina a consultar a referência oficial para completar qualquer classe específica sem adivinhar.
