-- Carregar a biblioteca Rayfield
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/Rayfield/main/Module.lua"))()

-- Configuração inicial
local senhaCorreta = "minhasenha123" -- Substitua pela sua senha desejada

-- Criar a janela principal
local Window = Rayfield:CreateWindow({
    Name = "Acesso ao Script",
    LoadingTitle = "Carregando Rayfield",
    LoadingSubtitle = "Verifique suas permissões",
    ConfigurationSaving = {
        Enabled = false -- Não precisa salvar configurações para esta tela inicial
    }
})

-- Criar uma guia inicial
local TabInicial = Window:CreateTab("Login", 4483362458)

-- Exibir caixa de texto para inserir a senha
TabInicial:CreateTextBox({
    Name = "Digite a Senha",
    PlaceholderText = "Senha aqui...",
    TextDisappear = true,
    Callback = function(Text)
        if Text == senhaCorreta then
            Rayfield:Notify({
                Title = "Acesso Permitido",
                Content = "Bem-vindo ao script!",
                Duration = 5,
                Image = 4483362458, -- Substitua pelo ID de imagem desejado
                Actions = {} -- Nenhuma ação adicional necessária
            })

            -- Abrir o menu principal após a senha ser verificada
            abrirMenuPrincipal()
        else
            Rayfield:Notify({
                Title = "Acesso Negado",
                Content = "Senha incorreta. Tente novamente.",
                Duration = 5,
                Image = 4483362458
            })
        end
    end
})

-- Função para abrir o menu principal após login
function abrirMenuPrincipal()
    local MainMenu = Rayfield:CreateWindow({
        Name = "Menu Principal",
        LoadingTitle = "Bem-vindo",
        LoadingSubtitle = "Iniciando o Script"
    })

    local TabPrincipal = MainMenu:CreateTab("Configurações", 4483362458)

    TabPrincipal:CreateButton({
        Name = "Clique Aqui",
        Callback = function()
            print("Botão pressionado no menu principal!")
        end
    })

    TabPrincipal:CreateSlider({
        Name = "Configuração",
        Range = {0, 100},
        Increment = 1,
        Suffix = "%",
        CurrentValue = 50,
        Callback = function(Value)
            print("Configuração ajustada para: " .. Value)
        end
    })

    MainMenu:LoadConfiguration()
end

-- Abrir a interface inicial
Rayfield:LoadConfiguration()
