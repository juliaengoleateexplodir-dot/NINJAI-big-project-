---
name: roblox-ui-development-complete
description: Skill abrangente para projetar, construir, programar, animar, adaptar, testar e otimizar interfaces gráficas Roblox com Luau, usando fontes oficiais e tutoriais da comunidade.
---

# Roblox UI Development — Skill Completa

## 0. Propósito e regras de uso

Esta skill ensina a criar interfaces para experiências Roblox com **Roblox Studio e Luau**: desde uma janela simples até menus completos, HUDs, inventários, lojas, configurações, sistemas de abas, interfaces responsivas, animações, componentes reutilizáveis e interfaces no mundo 3D.

### Como o assistente deve usar esta skill

Quando ajudar alguém a desenvolver uma UI:
1. Entenda se a interface é de tela (`ScreenGui`) ou está no mundo 3D (`SurfaceGui`/`BillboardGui`).
2. Identifique onde o código deve executar: cliente, servidor ou ambos.
3. Dê o caminho exato no Explorer e o tipo de script.
4. Prefira APIs oficiais e eventos adequados ao dispositivo.
5. Se pedirem código completo, inclua todas as partes necessárias, nomes dos objetos e instruções de instalação.
6. Explique como testar no Studio e em diferentes tamanhos de tela.
7. Não prometa ausência total de bugs; indique limitações e testes importantes.
8. Nunca invente nomes de classes, propriedades, eventos ou APIs. Se houver dúvida sobre comportamento atual, consulte as fontes oficiais ao final.
9. Trate scripts do cliente como não confiáveis para decisões importantes do jogo.
10. Use tutoriais de comunidade como complemento de técnicas, não como autoridade superior à documentação oficial.

---

# PARTE I — FUNDAMENTOS DA UI NO ROBLOX

## 1. O que é uma interface gráfica?

Uma UI (*User Interface*) é o conjunto de elementos visuais e interativos pelos quais o jogador recebe informações ou controla recursos do jogo.

Exemplos:
- HUD de vida, energia, munição ou pontuação;
- menu principal;
- menu de pausa e configurações;
- inventário e loja;
- barra de habilidades;
- notificações e caixas de diálogo;
- painel de administração de uma experiência;
- interface em uma tela física no mundo 3D;
- telas de seleção de personagem ou equipamento.

Uma boa UI não é apenas bonita. Ela deve comunicar hierarquia, responder rapidamente, ser legível e funcionar com mouse, toque e controles compatíveis.

## 2. Os principais tipos de contêiner

### `ScreenGui`
Desenha uma interface na tela do jogador. É a escolha comum para HUDs, menus, inventários e janelas.

Local habitual de criação: `StarterGui`. Ao entrar, o conteúdo é copiado para `PlayerGui` do jogador. A UI de tela e as interações locais são normalmente controladas pelo cliente.

### `SurfaceGui`
Desenha uma interface sobre uma superfície de uma peça 3D. É útil para telas de computadores, painéis, terminais e placas no mundo.

### `BillboardGui`
Desenha uma interface que fica posicionada no mundo e normalmente acompanha a câmera, como nome ou barra de vida sobre um personagem.

### `PluginGui`
Interfaces de plugins do Roblox Studio usam APIs próprias de plugins. Não confunda uma UI de jogo com uma UI de plugin do Studio.

Escolha o contêiner conforme a experiência. `ScreenGui`, `SurfaceGui` e `BillboardGui` não são intercambiáveis em todos os aspectos.

## 3. Onde ficam as UIs no Explorer?

Estrutura comum:

```text
StarterGui
└── MainGui (ScreenGui)
    └── MainFrame (Frame)
        ├── Header (Frame)
        │   ├── Title (TextLabel)
        │   └── CloseButton (TextButton)
        ├── Content (Frame)
        └── LocalScript
```

Outros locais importantes:
- `StarterPlayer > StarterPlayerScripts`: scripts de cliente que não precisam estar dentro de cada GUI.
- `StarterPlayer > StarterCharacterScripts`: lógica local associada ao personagem.
- `ReplicatedStorage`: módulos, recursos e `RemoteEvent` compartilhados quando apropriado.
- `ServerScriptService`: validação e lógica autoritativa no servidor.

Uma `ScreenGui` em `StarterGui` é copiada para `PlayerGui`. Um `LocalScript` precisa estar num contexto permitido para executar; um `Script` de servidor não deve ser usado como se fosse um controlador de UI local.

## 4. Objetos básicos de interface

### Contêineres e controles

- `Frame`: painel ou contêiner visual.
- `ScrollingFrame`: área com conteúdo rolável.
- `CanvasGroup`: agrupa elementos para efeitos como transparência do grupo.
- `ViewportFrame`: renderiza objetos 3D dentro de uma região da UI.
- `TextLabel`: mostra texto.
- `TextButton`: botão com texto.
- `TextBox`: campo de entrada de texto.
- `ImageLabel`: mostra uma imagem.
- `ImageButton`: botão baseado em imagem.
- `VideoFrame`: reprodução de vídeo compatível com o sistema de ativos e as regras atuais.
- `UIListLayout`: organiza filhos em linha ou coluna.
- `UIGridLayout`: organiza filhos em grade.
- `UITableLayout`: organiza filhos em formato de tabela.
- `UIPageLayout`: organiza páginas e transições entre páginas.
- `UIPadding`: margens internas.
- `UICorner`: cantos arredondados.
- `UIStroke`: contorno.
- `UIGradient`: gradiente visual.
- `UIScale`: fator de escala de elementos GUI.
- `UISizeConstraint`: limites de tamanho.
- `UIAspectRatioConstraint`: mantém uma proporção de aspecto.
- `UIFlexItem`: configura comportamentos de flexibilidade quando usado com layouts compatíveis.

Esses objetos têm propriedades e comportamentos próprios. Consulte a referência oficial antes de presumir que todos os objetos aceitam as mesmas propriedades.

## 5. Propriedades essenciais de `GuiObject`

As propriedades mais utilizadas incluem:

- `Name`: nome no Explorer.
- `Parent`: objeto pai.
- `Position`: posição relativa ao pai.
- `Size`: tamanho.
- `AnchorPoint`: ponto do objeto usado como referência para posicionamento.
- `BackgroundColor3`: cor do fundo.
- `BackgroundTransparency`: transparência do fundo.
- `Visible`: visibilidade.
- `ZIndex`: ordem de desenho.
- `Rotation`: rotação visual.
- `ClipsDescendants`: recorta filhos que saem dos limites do pai.
- `LayoutOrder`: ordem usada por layouts compatíveis.
- `Active`: participação em determinados comportamentos de entrada/interação.
- `Selectable`: possibilidade de seleção por navegação de controles, quando aplicável.

Nem toda propriedade existe em toda classe. Por exemplo, `TextLabel` tem propriedades de texto; `ImageLabel` tem propriedades de imagem.

## 6. `UDim2`: posicionamento e tamanho

`UDim2` combina escala e offset em dois eixos:

```lua
UDim2.new(xScale, xOffset, yScale, yOffset)
```

- **Scale**: proporção do tamanho do pai.
- **Offset**: quantidade em pixels de UI (offsets de interface) adicionada à escala.
- `UDim2.fromScale(x, y)`: cria valores apenas de escala.
- `UDim2.fromOffset(x, y)`: cria valores apenas de offset.

Exemplos:

```lua
frame.Size = UDim2.fromScale(0.5, 0.4)
frame.Position = UDim2.fromScale(0.25, 0.2)

button.Size = UDim2.fromOffset(160, 44)
```

Use escala para dimensões que precisam acompanhar a tela e offset para tamanhos fixos convenientes, como a altura de um botão. Não existe uma regra universal de “sempre escala” ou “sempre offset”: layouts robustos normalmente combinam ambos.

## 7. `AnchorPoint`

`AnchorPoint` define qual ponto do objeto é alinhado com `Position`.

```lua
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.fromScale(0.5, 0.5)
```

O exemplo posiciona o centro do frame no centro do pai.

Valores típicos:
- `(0, 0)`: canto superior esquerdo;
- `(0.5, 0.5)`: centro;
- `(1, 1)`: canto inferior direito.

O `AnchorPoint` não altera sozinho o tamanho do objeto; ele muda a referência usada para posicioná-lo.

## 8. `ZIndex` e sobreposição

`ZIndex` controla a ordem de desenho de objetos GUI dentro das regras de ordenação aplicáveis. Valores maiores geralmente aparecem à frente de valores menores dentro do mesmo contexto de ordenação.

Use uma convenção clara:
- fundo;
- conteúdo;
- controles;
- pop-ups;
- overlays;
- tooltips.

Não aumente todos os `ZIndex` aleatoriamente. Se um elemento não aparecer, verifique também:
- `Visible`;
- transparência;
- `Parent`;
- `ClipsDescendants`;
- ordenação do `ScreenGui`, incluindo `DisplayOrder`;
- tamanho e posição;
- elementos que cobrem a área;
- contexto de `ZIndexBehavior`.

## 9. Cor, transparência e acabamento

Propriedades comuns:
- `Color3.fromRGB(r, g, b)`;
- `BackgroundColor3`;
- `BackgroundTransparency`;
- `TextColor3`;
- `ImageColor3`;
- `ImageTransparency`;
- `UIStroke.Color`;
- `UIStroke.Thickness`;
- `UIStroke.Transparency`;
- `UICorner.CornerRadius`;
- `UIGradient.Color` e `UIGradient.Transparency`.

Exemplo:

```lua
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local outline = Instance.new("UIStroke")
outline.Thickness = 1
outline.Color = Color3.fromRGB(70, 78, 90)
outline.Parent = frame
```

O estilo deve manter contraste suficiente para leitura. Não dependa apenas da cor para comunicar um estado: use também texto, ícones ou formas.

---

# PARTE II — CRIANDO UMA UI NO STUDIO

## 10. Criar manualmente pelo Explorer

Fluxo típico:
1. Abra Roblox Studio e a experiência.
2. Abra `View > Explorer` e `View > Properties` se estiverem ocultos.
3. Em `StarterGui`, insira um `ScreenGui`.
4. Renomeie com um nome que indique a finalidade, como `InventoryGui`.
5. Insira um `Frame` dentro do `ScreenGui`.
6. Ajuste `Size`, `Position`, `AnchorPoint`, cores e transparência em Properties.
7. Insira `TextLabel`, `TextButton`, `ImageLabel` ou outros objetos dentro do frame.
8. Organize os filhos com layouts quando fizer sentido.
9. Adicione scripts locais apenas para comportamento que precisa ocorrer no cliente.
10. Use Play/Test para validar o comportamento e o tamanho.

Dica: escolha nomes consistentes. `CloseButton` é mais fácil de entender que `TextButton17`.

## 11. Criar UI por código

`Instance.new()` cria instâncias:

```lua
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ExampleGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Name = "MainPanel"
panel.Size = UDim2.fromScale(0.45, 0.5)
panel.Position = UDim2.fromScale(0.275, 0.25)
panel.BackgroundColor3 = Color3.fromRGB(30, 33, 39)
panel.BorderSizePixel = 0
panel.Parent = screenGui
```

Esse exemplo usa `LocalPlayer`, portanto deve executar em contexto de cliente, como um `LocalScript`. Em uma UI criada manualmente em `StarterGui`, o Roblox cuida da cópia para `PlayerGui`.

Crie o pai antes de adicionar os filhos quando quiser manter a hierarquia clara. Defina as propriedades importantes antes de mostrar uma interface grande para reduzir estados intermediários visíveis.

## 12. Exemplo completo: janela com botão de fechar

Coloque este `LocalScript` em `StarterPlayer > StarterPlayerScripts`. Ele cria uma janela simples no cliente:

```lua
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("DemoWindowGui")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "DemoWindowGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local panel = Instance.new("Frame")
panel.Name = "Window"
panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.Position = UDim2.fromScale(0.5, 0.5)
panel.Size = UDim2.new(0.8, 0, 0.55, 0)
panel.BackgroundColor3 = Color3.fromRGB(30, 33, 39)
panel.BorderSizePixel = 0
panel.Parent = gui

local limit = Instance.new("UISizeConstraint")
limit.MinSize = Vector2.new(280, 200)
limit.MaxSize = Vector2.new(700, 500)
limit.Parent = panel

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = panel

local title = Instance.new("TextLabel")
title.Name = "Title"
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(16, 0)
title.Size = UDim2.new(1, -64, 0, 48)
title.Font = Enum.Font.GothamBold
title.Text = "Minha interface"
title.TextColor3 = Color3.fromRGB(240, 242, 245)
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = panel

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.AnchorPoint = Vector2.new(1, 0)
closeButton.Position = UDim2.new(1, -8, 0, 8)
closeButton.Size = UDim2.fromOffset(32, 32)
closeButton.Text = "×"
closeButton.TextSize = 22
closeButton.Font = Enum.Font.Gotham
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.BackgroundColor3 = Color3.fromRGB(55, 60, 69)
closeButton.Parent = panel

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

closeButton.Activated:Connect(function()
    gui:Destroy()
end)
```

O exemplo ilustra a estrutura e o evento `Activated`. Um produto final pode precisar de um botão de reabrir, navegação de teclado/controle, efeitos sonoros e tratamento de foco.

## 13. Como encontrar propriedades no Studio

Selecione um objeto no Explorer e use Properties para consultar suas propriedades. A documentação da classe mostra o que cada propriedade significa, os tipos aceitos e se ela é herdada.

Quando uma propriedade não aparece:
- confirme a classe selecionada;
- confirme que a propriedade existe para aquela classe;
- procure a propriedade na documentação da API;
- confira se o objeto é uma instância real ou um objeto de layout/modificador.

Não confunda propriedades de uma classe com propriedades de seus filhos.

---

# PARTE III — LAYOUTS, RESPONSIVIDADE E MOBILE

## 14. Por que a responsividade importa?

Jogadores podem usar telas de celular, tablet, computador, console e diferentes proporções. Uma UI projetada apenas para uma resolução pode cortar texto, cobrir controles ou ficar pequena demais.

Testar a UI em um dispositivo não prova que ela funciona em todos os dispositivos.

## 15. Estratégia de layout responsivo

Combine:
- `Scale` para dimensões relativas;
- `Offset` para dimensões fixas convenientes;
- `AnchorPoint` para alinhamento previsível;
- `UISizeConstraint` para limitar extremos;
- `UIAspectRatioConstraint` para proporções;
- `UIListLayout`/`UIGridLayout` para organizar conteúdo;
- `UIPadding` para margens;
- `ScrollingFrame` quando o conteúdo não cabe;
- `AutomaticSize` em classes compatíveis, com cuidado para evitar ciclos ou layouts inesperados;
- `UIScale` quando uma escala global realmente fizer sentido.

Não aplique `UIScale` cegamente em toda a interface. O tamanho de texto, a área clicável e a legibilidade precisam ser avaliados no contexto de cada dispositivo.

## 16. Emulador de dispositivos

No Roblox Studio:
1. Abra as ferramentas de teste.
2. Ative Device Emulator (a localização exata no menu pode variar com a versão do Studio).
3. Escolha formatos de telefone, tablet, desktop ou console disponíveis.
4. Teste orientação e proporção quando disponíveis.
5. Confirme que os controles permanecem acessíveis.
6. Teste também com o jogo rodando, não apenas olhando a UI parada no editor.

Observe:
- títulos que quebram em várias linhas;
- botões pequenos demais;
- elementos que ficam atrás de controles de sistema;
- listas sem rolagem;
- conteúdo cortado;
- distância entre controles;
- posição da UI em diferentes proporções.

## 17. Safe areas e insets

A tela pode incluir áreas reservadas por interfaces do sistema ou controles da plataforma. Considere `ScreenGui` e suas propriedades relacionadas a insets, incluindo `IgnoreGuiInset`, conforme o layout desejado e a API atual.

Não defina `IgnoreGuiInset = true` por hábito. Verifique se a UI deve respeitar a área segura e teste em dispositivos reais ou emuladores.

## 18. Layouts automáticos

### `UIListLayout`
Organiza elementos em linha ou coluna. Propriedades importantes podem incluir `FillDirection`, `HorizontalAlignment`, `VerticalAlignment`, `Padding`, `SortOrder` e `Wrap`, dependendo da API atual.

### `UIGridLayout`
Organiza filhos em células uniformes. Útil para inventários, seletores de itens e catálogos.

### `UITableLayout`
Organiza filhos em linhas e colunas de tabela.

### `UIPageLayout`
Organiza páginas e pode transitar entre elas.

Quando um layout controla a posição ou tamanho, definir `Position`/`Size` manualmente em todos os filhos pode não produzir o resultado esperado. Entenda quais propriedades são controladas pelo layout.

## 19. `AutomaticSize`

`AutomaticSize` pode ajustar o tamanho de certos objetos conforme o conteúdo. É útil para mensagens de chat, cartões com texto e elementos que crescem com o conteúdo.

Boas práticas:
- configure corretamente `TextWrapped`;
- ajuste o eixo que deve crescer;
- não crie dependências circulares entre o tamanho do pai e o do filho;
- use `UIPadding` para manter margens;
- teste textos longos, vazios e idiomas diferentes;
- combine com `ScrollingFrame` quando o conteúdo total puder ultrapassar a tela.

## 20. `ScrollingFrame`

Use quando houver conteúdo maior que a área visível:
- inventários;
- listas de scripts;
- logs;
- menus longos;
- árvores de hierarquia;
- listas de mensagens.

Propriedades importantes incluem `CanvasSize`, `CanvasPosition`, `ScrollingDirection`, `ScrollBarThickness` e `AutomaticCanvasSize`. Consulte a documentação atual para os valores e comportamentos suportados.

Exemplo básico:

```lua
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.fromScale(1, 1)
scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
scroll.ScrollBarThickness = 6
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.Parent = parentFrame
```

Esse exemplo supõe que `parentFrame` exista. Para conteúdo dinâmico, atualize o tamanho do canvas de forma consistente ou configure `AutomaticCanvasSize` quando apropriado.

---

# PARTE IV — INTERAÇÃO, EVENTOS E NAVEGAÇÃO

## 21. Eventos de botões

`TextButton` e `ImageButton` são botões GUI. Para ações multiplataforma, `Activated` normalmente é uma boa escolha.

```lua
button.Activated:Connect(function()
    print("Botão ativado")
end)
```

Não use `MouseButton1Click` como única solução se a UI também precisa oferecer suporte consistente a toque e controles. Escolha eventos conforme a interação desejada e confirme a API atual.

## 22. Alternar um painel

```lua
local isOpen = false

toggleButton.Activated:Connect(function()
    isOpen = not isOpen
    settingsPanel.Visible = isOpen
end)
```

Mantenha o estado em um único lugar. Evite criar múltiplas conexões cada vez que o painel abre.

## 23. Sistema de abas

Estrutura sugerida:

```text
MainGui
└── Window
    ├── Sidebar
    │   ├── HomeTab
    │   ├── SettingsTab
    │   └── AboutTab
    └── Pages
        ├── HomePage
        ├── SettingsPage
        └── AboutPage
```

Princípios:
- cada botão ativa uma página;
- a função de navegação deve ser reutilizável;
- somente a página selecionada fica visível;
- o botão selecionado deve ter um estado visual claro;
- evite copiar a lógica inteira em cada botão.

Exemplo:

```lua
local pages = {
    Home = homePage,
    Settings = settingsPage,
    About = aboutPage,
}

local function showPage(pageName)
    for name, page in pairs(pages) do
        page.Visible = name == pageName
    end
end

homeButton.Activated:Connect(function()
    showPage("Home")
end)

settingsButton.Activated:Connect(function()
    showPage("Settings")
end)

aboutButton.Activated:Connect(function()
    showPage("About")
end)

showPage("Home")
```

Os nomes `homePage`, `settingsPage`, `aboutPage` e os botões devem ser referências válidas criadas antes deste trecho.

## 24. Caixa de texto e validação

`TextBox` permite entrada de texto. Não confie na entrada sem validação.

```lua
textBox.FocusLost:Connect(function(enterPressed)
    local text = textBox.Text
    if #text > 100 then
        textBox.Text = string.sub(text, 1, 100)
    end
end)
```

Este é um exemplo simplificado de limite de comprimento, não uma validação universal. Valide tipos e conteúdo de acordo com a funcionalidade. Para qualquer operação importante, o servidor precisa validar os dados recebidos.

## 25. Arrastar janelas

Para uma janela arrastável, considere `UIDragDetector` e sua documentação, em vez de inventar um sistema de input para cada dispositivo. Verifique a configuração, os eventos e as restrições necessárias para o comportamento desejado.

Se implementar arraste manualmente:
- trate mouse e toque;
- desconecte eventos corretamente;
- limite o movimento à área permitida;
- não interfira em botões e campos de texto;
- teste com telas pequenas;
- evite depender de APIs de entrada que não se aplicam ao dispositivo.

## 26. Navegação por teclado e controle

Considere jogadores que navegam sem mouse:
- use `Selectable` e propriedades relacionadas quando apropriado;
- mantenha uma ordem de foco previsível;
- garanta um estado visual de seleção;
- teste com gamepad;
- não faça da cor o único indicador de seleção;
- ofereça formas claras de fechar menus e voltar.

Use `ContextActionService` ou APIs oficiais adequadas quando ações precisarem de bindings multiplataforma.

---

# PARTE V — ANIMAÇÃO, EFEITOS E ESTILO

## 27. `TweenService`

`TweenService` interpola propriedades de instâncias entre valores ao longo do tempo.

```lua
local TweenService = game:GetService("TweenService")

local tweenInfo = TweenInfo.new(
    0.2,
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.Out
)

local tween = TweenService:Create(button, tweenInfo, {
    BackgroundTransparency = 0.1
})

tween:Play()
```

Boas práticas:
- guarde referências a tweens quando precisar cancelá-los;
- evite vários tweens concorrentes na mesma propriedade;
- use durações curtas para feedback;
- não anime tudo ao mesmo tempo;
- preserve legibilidade e resposta rápida;
- teste o efeito em dispositivos de desempenho mais baixo.

## 28. Animações de abrir e fechar

Um painel pode animar transparência, posição ou escala. Garanta que o estado lógico da interface corresponda ao visual.

Uma estratégia comum:
1. ao abrir, tornar o painel visível;
2. configurar o estado inicial;
3. tocar o tween de entrada;
4. ao fechar, tocar o tween de saída;
5. tornar invisível depois da saída;
6. cancelar tweens antigos se o usuário alternar rapidamente.

Não dependa de `task.wait()` fixo para sincronizar uma animação se o evento de conclusão do tween puder ser usado de forma mais segura.

## 29. Hover e estados de botão

Hover é mais relevante em dispositivos com ponteiro; em dispositivos de toque não existe necessariamente um estado de hover persistente. Use `GuiObject`/`GuiButton` e os eventos de estado apropriados, verificando a documentação da API.

Estados visuais recomendados:
- normal;
- hover, quando disponível;
- pressionado;
- selecionado;
- desativado;
- carregando;
- erro ou confirmação.

Não dependa exclusivamente de hover para revelar uma ação necessária no mobile.

## 30. Design visual e hierarquia

Antes de programar, defina:
- finalidade da interface;
- ação principal;
- informações prioritárias;
- estilo de cores;
- tipografia;
- espaçamento;
- raio de cantos;
- espessura de contornos;
- comportamento em telas pequenas;
- estados vazios, carregando, sucesso e erro.

Um estilo minimalista costuma usar poucos tons, espaçamento consistente, textos curtos e contrastes claros. Um estilo clássico de ferramenta pode usar painéis compactos e contornos discretos, mas ainda precisa ser legível em mobile.

## 31. Tokens de design

Mantenha valores compartilhados num módulo ou tabela de configuração:

```lua
local Theme = {
    Background = Color3.fromRGB(24, 26, 30),
    Panel = Color3.fromRGB(32, 35, 41),
    Text = Color3.fromRGB(235, 238, 242),
    MutedText = Color3.fromRGB(155, 162, 172),
    Accent = Color3.fromRGB(100, 180, 255),
    Radius = 8,
    SmallGap = 6,
    LargeGap = 14,
}

return Theme
```

Esse módulo só define valores. Para usá-lo, coloque-o em local acessível ao script que o requer e use `require()` conforme o contexto.

## 32. Ícones e imagens

Use `ImageLabel` ou `ImageButton` para imagens. Verifique:
- se o asset está autorizado e disponível;
- se o ID é o correto;
- se a imagem tem resolução suficiente;
- se a transparência e o recorte são apropriados;
- se o asset pode ser usado na experiência;
- se há texto alternativo ou rótulo que explique a ação.

Não invente IDs de ativos nem presuma que qualquer URL é aceita como imagem. Para recursos de terceiros, verifique licenças e permissões.

## 33. Fontes e texto

Propriedades relevantes:
- `Font` ou propriedades de fonte atuais disponíveis para a classe;
- `Text`;
- `TextColor3`;
- `TextSize`;
- `TextScaled`;
- `TextWrapped`;
- `TextXAlignment`;
- `TextYAlignment`;
- `TextTruncate`, quando suportado;
- `RichText`, se a formatação embutida for necessária.

Evite ativar `TextScaled` indiscriminadamente em cada texto: pode causar diferenças de leitura ou tamanhos inesperados. Defina limites e teste strings longas.

---

# PARTE VI — COMPONENTES REUTILIZÁVEIS E ARQUITETURA

## 34. Reutilização

Não copie dezenas de vezes a mesma criação de botão. Crie funções que configurem os elementos com parâmetros claros.

```lua
local function createButton(parent, name, text)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Text = text
    button.Size = UDim2.fromOffset(120, 36)
    button.BackgroundColor3 = Color3.fromRGB(48, 54, 64)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Parent = parent
    return button
end
```

A função cria um botão básico. O chamador pode adicionar `UICorner`, `UIStroke`, eventos e regras de layout conforme necessário.

## 35. Separar view, controller e dados

Para uma UI grande, considere dividir responsabilidades:
- **View**: objetos visuais e aparência;
- **Controller**: ações, navegação e estado da interface;
- **Model/data**: dados apresentados pela UI;
- **Network boundary**: chamadas remotas e respostas do servidor.

Essa separação é uma recomendação de arquitetura, não uma exigência do Roblox. Escolha o nível de abstração apropriado para o tamanho do projeto.

## 36. `ModuleScript` para controladores

Um `ModuleScript` pode devolver funções e tabelas que organizam a UI. Ele executa no contexto do script que o requer; não é um serviço de rede automático.

Evite:
- ciclos de `require()`;
- múltiplos controladores que disputam a mesma propriedade;
- conexões de eventos sem gerenciamento;
- dependências de `LocalPlayer` em módulos usados pelo servidor;
- recriar a UI completa a cada clique.

## 37. Estado e limpeza

Quando uma janela fecha ou é destruída:
- desconecte eventos que ainda possam disparar;
- cancele tweens quando apropriado;
- pare tarefas periódicas;
- remova referências a objetos destruídos;
- impeça conexões duplicadas ao reabrir.

`Instance:Destroy()` remove a instância e seus descendentes, mas não substitui o planejamento do ciclo de vida de tarefas e conexões criadas por scripts.

---

# PARTE VII — UI NO MUNDO 3D

## 38. `SurfaceGui`

Use quando a UI precisa estar associada à superfície de uma peça. Configure `Adornee` quando necessário, `Face`, dimensões e demais propriedades suportadas.

Exemplos de uso:
- tela de computador dentro do jogo;
- painel de controle de uma máquina;
- placa interativa;
- monitor de uma sala.

A interação depende do tipo de controle e da configuração. Teste com o método de entrada pretendido.

## 39. `BillboardGui`

Útil para rótulos ou indicadores posicionados no mundo, como:
- nome de NPC;
- barra de vida;
- marcador de objetivo;
- ícone acima de um objeto.

A posição do objeto e a orientação da câmera afetam como ele aparece. Controle distância, tamanho e visibilidade para evitar poluir a cena.

## 40. `ViewportFrame`

`ViewportFrame` renderiza objetos 3D dentro de uma área da UI. É útil para pré-visualizações de itens, personagens, modelos ou demonstrações.

Normalmente exige:
- uma câmera associada ao viewport;
- objetos para renderizar;
- posição e enquadramento da câmera;
- iluminação/material apropriados;
- gerenciamento do custo de renderização.

Não confunda um `ViewportFrame` com um modelo 3D no `Workspace`: ele possui seu próprio contexto de renderização e não é uma substituição geral para o mundo.

---

# PARTE VIII — SEGURANÇA E CLIENTE/SERVIDOR

## 41. UI não é autoridade

Uma UI criada no cliente pode ser alterada pelo próprio cliente. Portanto, esconder um botão ou desabilitar um controle não protege a lógica do jogo.

Exemplos de operações que exigem validação no servidor:
- gastar ou receber moedas;
- comprar itens;
- alterar inventário;
- conceder permissões;
- causar dano;
- mudar o progresso salvo;
- executar ações administrativas.

## 42. Comunicação segura com remotes

O cliente pode solicitar uma ação por `RemoteEvent`, mas o servidor deve verificar:
- tipo dos argumentos;
- valores dentro de limites válidos;
- autorização do jogador;
- distância e estado do jogo;
- cooldown ou frequência de chamadas;
- existência e preço real do item;
- se a operação já foi processada.

Nunca confie no cliente para enviar o preço final de uma compra ou a quantidade de moedas que deseja receber.

## 43. Não misture visual com autoridade

Um `LocalScript` pode abrir um menu, animar um botão e mostrar um resultado. A alteração real de um recurso compartilhado deve ser confirmada pelo servidor quando a regra do jogo exigir autoridade.

Evite colocar segredos ou tokens privados em `LocalScript`, `ReplicatedStorage` ou qualquer lugar replicado ao jogador.

---

# PARTE IX — DESEMPENHO E DEBUG

## 44. Otimização

- Evite criar milhares de instâncias desnecessariamente.
- Reutilize componentes quando fizer sentido.
- Não recrie toda a UI a cada mudança de aba.
- Não faça cálculos pesados por frame sem necessidade.
- Prefira eventos a loops de polling.
- Limite listas muito grandes e use rolagem.
- Considere criação sob demanda para catálogos e hierarquias grandes.
- Desconecte eventos e encerre tarefas quando a UI deixa de existir.
- Evite transparências e efeitos caros em grandes quantidades sem testar.
- Meça o problema com ferramentas de profiling do Studio.

Não existe um número único de objetos que seja sempre seguro ou inseguro. O custo depende do tipo de instância, dispositivo, frequência de atualização e complexidade da interface.

## 45. Depuração de UI

Se a UI não aparece, verifique:
1. O script executa no contexto correto?
2. O `ScreenGui` está em `StarterGui` ou `PlayerGui`?
3. `Visible` está ativado?
4. A transparência não está ocultando o objeto?
5. `Size` não é zero?
6. `Position` está dentro da área visível?
7. `Parent` é o esperado?
8. `ZIndex` e `DisplayOrder` estão corretos?
9. `ClipsDescendants` está cortando o conteúdo?
10. O `Output` contém erro?
11. O objeto está sendo destruído por outro script?
12. Um layout está sobrescrevendo tamanho ou posição?

Use `print()` e `warn()` com contexto útil. Remova logs temporários depois de corrigir o problema.

## 46. Erros comuns

### Botão não responde
- confira se o evento foi conectado;
- confira se outro elemento está por cima;
- confira se o botão está visível e ativo;
- use `Activated` para entrada multiplataforma quando adequado;
- confirme que o script está executando.

### Elementos se sobrepõem
- verifique `ZIndex`, `DisplayOrder`, `AnchorPoint` e layouts;
- confira se os pais estão recortando conteúdo;
- adote uma convenção de camadas.

### Texto é cortado
- ajuste tamanho, wrapping e alinhamento;
- use `AutomaticSize` com cuidado;
- considere rolagem;
- teste textos maiores e diferentes idiomas.

### UI fica fora da tela no celular
- revise Scale/Offset;
- use constraints e layouts;
- respeite insets;
- teste com emulador e dispositivo real.

### Lista não rola
- confira `CanvasSize` ou `AutomaticCanvasSize`;
- confirme que o conteúdo é maior que a área visível;
- confira `ScrollingDirection`;
- veja se os itens são filhos do `ScrollingFrame` correto.

### Interface duplica após respawn
- confira `ResetOnSpawn`;
- evite criar a mesma GUI em múltiplos locais sem coordenação;
- procure conexões ou scripts duplicados.

---

# PARTE X — CHECKLIST DE PRODUÇÃO

## 47. Antes de considerar a UI pronta

### Estrutura
- [ ] Cada objeto tem nome compreensível.
- [ ] A hierarquia do Explorer é simples e organizada.
- [ ] O tipo de script e seu local são apropriados.
- [ ] Componentes repetidos são reutilizados quando faz sentido.

### Design
- [ ] Há hierarquia visual clara.
- [ ] Texto e controles são legíveis.
- [ ] Os estados de botão são visíveis.
- [ ] O layout não depende apenas de cores.
- [ ] O estilo é consistente.

### Responsividade
- [ ] Testada em telefone.
- [ ] Testada em desktop.
- [ ] Testada em diferentes proporções.
- [ ] Conteúdo longo pode ser rolado.
- [ ] Nenhum controle importante fica inacessível.
- [ ] Inset e safe area foram considerados.

### Interação
- [ ] Botões respondem a mouse e toque quando necessário.
- [ ] Navegação entre abas funciona.
- [ ] O estado da UI não se contradiz.
- [ ] Não há conexões duplicadas.
- [ ] Animações não bloqueiam ações essenciais.

### Segurança
- [ ] Operações importantes são validadas pelo servidor.
- [ ] O cliente não controla valores autoritativos.
- [ ] Argumentos remotos são validados.
- [ ] Segredos não estão em conteúdo replicado.

### Qualidade
- [ ] Output não apresenta erros inesperados.
- [ ] A UI foi testada após respawn.
- [ ] Foi testada com rede/múltiplos jogadores quando relevante.
- [ ] O desempenho foi verificado em dispositivos de menor capacidade.

---

# PARTE XI — FONTES E TUTORIAIS

As fontes abaixo são referências para estudo. A documentação do Roblox Creator Hub é a fonte principal para comportamento oficial de classes, propriedades e serviços. Tutoriais da comunidade ajudam a aprender processos visuais e práticas de design, mas podem conter opiniões, técnicas antigas ou exemplos incompletos.

## 48. Documentação oficial Roblox

1. **User interface — visão geral**
   https://create.roblox.com/docs/ui
   Introduz UI de tela e no mundo, objetos básicos, layouts, modificadores e interatividade.

2. **Implement designs in Studio**
   https://create.roblox.com/docs/tutorials/curriculums/user-interface-design/implement-designs-in-studio
   Tutorial de currículo para transformar designs em objetos de UI no Studio e testar dispositivos.

3. **Create interactive UI**
   https://create.roblox.com/docs/tutorials/use-case-tutorials/ui/interactive-ui
   Botões, menus de configurações, sliders e controladores com ModuleScripts.

4. **Grid and table layouts**
   https://create.roblox.com/docs/ui/grid-table-layouts
   Explica layouts em grade e tabela.

5. **Positioning and sizing GuiObjects**
   https://create.roblox.com/docs/building-and-visuals/ui/positioning-and-sizing-guiobjects
   Posicionamento, tamanho e fatores multiplataforma.

6. **Style Editor**
   https://create.roblox.com/docs/ui/styling/editor
   Estilos compartilhados, regras e tokens de design.

7. **UI drag detectors**
   Comece pela visão geral oficial: https://create.roblox.com/docs/ui
   Consulte a classe `UIDragDetector` na referência da API para as propriedades e eventos atuais.

8. **Roblox Engine API Reference**
   https://create.roblox.com/docs/reference/engine
   Fonte de referência para classes, propriedades, métodos e eventos.

9. **Luau**
   https://create.roblox.com/docs/luau
   Referência da linguagem utilizada para programar os comportamentos.

## 49. Tutoriais da comunidade

1. **Responsive GUI Frames — video tutorial**, Developer Forum
   https://devforum.roblox.com/t/responsive-gui-frames-video-tutorial/1412327
   Introduz AnchorPoint, Position, Size, Rotation, Scale e Offset. Use como introdução; teste as técnicas por conta própria.

2. **How to make an interactive and engaging main menu!**, Developer Forum
   https://devforum.roblox.com/t/how-to-make-an-interactive-and-engaging-main-menu/1522214
   Tutorial comunitário sobre estrutura de menu principal e considerações de tamanho.

3. **Here's How to Create a Modern Sleek UI Design**, Developer Forum
   https://devforum.roblox.com/t/heres-how-to-make-a-modern-sleek-ui-design-ui-tutorial/2528850
   Exemplo comunitário de design minimalista, painel de configurações e animações de hover.

4. **The SECRET To Responsive UI in Roblox**, vídeo de gfxcomet
   https://www.youtube.com/watch?v=JMhsBpN5MNM
   Demonstra conceitos de UI responsiva usando um exemplo prático.

5. **Roblox demo — Responsive UI design**, vídeo de Britton
   https://www.youtube.com/watch?v=bFFoIbdeNFY
   Demonstrações visuais de design responsivo.

### Como avaliar tutoriais de terceiros

Antes de copiar código:
- confira a data e a versão do Studio;
- compare classes e propriedades com a API Reference;
- teste em uma experiência de desenvolvimento;
- verifique se o código cria conexões duplicadas;
- confirme que a lógica importante é validada no servidor;
- não use um modelo ou script sem entender suas dependências e permissões.

---

# PARTE XII — PADRÃO DE RESPOSTA DA SKILL

Quando alguém pedir uma interface específica, a resposta deve conter, conforme a complexidade:

1. **Resumo da arquitetura:** quais objetos compõem a UI.
2. **Hierarquia do Explorer:** árvore com os nomes exatos.
3. **Local de instalação:** `StarterGui`, `StarterPlayerScripts` etc.
4. **Código completo:** sem omitir dependências essenciais.
5. **Como testar:** instruções para Studio e dispositivos.
6. **Como personalizar:** cores, dimensões, textos e ícones.
7. **Limitações:** dependências de assets, permissões, APIs e comportamento de entrada.
8. **Segurança:** separação entre apresentação no cliente e regras do servidor.

Para pedidos de design, explique os princípios visuais e a implementação. Para pedidos de depuração, identifique o erro concreto antes de reescrever partes que já funcionam. Para código grande, prefira modularidade e gerenciamento de ciclo de vida.

## Princípio final

A melhor UI Roblox é aquela que comunica bem, responde sem atraso perceptível, se adapta aos dispositivos previstos, é acessível, tem código organizado e não confia no cliente para aplicar regras importantes do jogo. Use documentação oficial para verificar APIs e tutoriais comunitários para aprender técnicas complementares.
