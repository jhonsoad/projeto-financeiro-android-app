# 🚀 ByteBank - Aplicativo de Gerenciamento Financeiro

## 🎯 Sobre o Projeto

Este repositório contém um aplicativo completo de gerenciamento financeiro, o **ByteBank**, desenvolvido com Flutter. O objetivo é fornecer aos usuários uma ferramenta intuitiva e eficiente para controlar suas finanças, permitindo a visualização de saldos, o acompanhamento de transações e a realização de operações financeiras de forma simples e segura.

A aplicação é construída de forma modular e utiliza o Firebase como backend para garantir a sincronização de dados em tempo real e uma experiência de usuário fluida.

## ✨ Funcionalidades

* **Autenticação de Usuários:** Sistema completo de login e cadastro utilizando o Firebase Auth.
* **Dashboard Intuitivo:** Tela principal com um resumo do saldo atual e atalhos para as principais funcionalidades.
* **Extrato Detalhado:** Visualização de todas as transações (depósitos e transferências) agrupadas por mês.
* **Gerenciamento de Transações:**
    * Criação de novas transações de débito (transferência) e crédito (depósito).
    * Upload de comprovantes para transações.
    * Edição do valor de transações existentes.
    * Exclusão de transações com modal de confirmação.
* **Filtro de Transações:** Filtre o extrato por categoria ou por uma data específica.
* **Múltiplas Seções:** Navegação via menu lateral para diferentes áreas como Início, Transferências, Investimentos e Outros Serviços.
* **Visualização de Dados:** Gráfico de pizza na seção de investimentos para exibir estatísticas sobre as transações.

## 🏛️ Arquitetura e Tecnologias

A arquitetura do projeto segue as melhores práticas de desenvolvimento com Flutter, com uma clara separação de responsabilidades entre telas, widgets, modelos e serviços.

### Tecnologias Principais Utilizadas:

* **Flutter & Dart:** Framework e linguagem para o desenvolvimento de aplicações multiplataforma de alta performance.
* **Firebase:** Plataforma utilizada como backend para diversas funcionalidades:
    * **Firebase Authentication:** Para gerenciar o cadastro e login de usuários.
    * **Cloud Firestore:** Banco de dados NoSQL para armazenar dados de usuários e transações.
    * **Firebase Storage:** Para o armazenamento e recuperação dos comprovantes de transação.
* **`flutter_svg`:** Biblioteca para renderizar imagens vetoriais (SVG), utilizada nos ícones da aplicação.
* **`fl_chart`:** Para a criação de gráficos dinâmicos e interativos na seção de estatísticas.
* **`image_picker`:** Plugin para permitir a seleção de imagens da galeria ou o uso da câmera para anexar comprovantes.
* **`intl`:** Pacote para internacionalização e formatação de datas e valores monetários no padrão brasileiro.
* **`shared_preferences`:** Para armazenamento local de dados simples no dispositivo.

## 📁 Estrutura de Pastas e Organização

A estrutura do projeto está organizada para promover a modularidade e a escalabilidade, facilitando a manutenção e o desenvolvimento de novas funcionalidades.

```
.
├── android/            # Configurações e código específico para Android
├── assets/             # Recursos estáticos como ícones e imagens
│   ├── icons/
│   └── images/
├── ios/                # Configurações e código específico para iOS
├── lib/                # Diretório principal com todo o código Dart da aplicação
│   ├── models/         # Modelos de dados (ex: Transaction)
│   ├── screens/        # Widgets que representam as telas principais
│   ├── theme/          # Definição do tema visual da aplicação
│   ├── utils/          # Classes utilitárias (ex: LocalStorage)
│   ├── widgets/        # Widgets reutilizáveis da aplicação
│   │   ├── common/     # Widgets genéricos (botões, inputs, etc.)
│   │   ├── dashboard/  # Widgets específicos da tela de Dashboard
│   │   └── home/       # Widgets específicos da tela Home
│   ├── main.dart       # Ponto de entrada da aplicação
│   └── routes.dart     # Definição das rotas de navegação
├── test/               # Testes automatizados
├── pubspec.yaml        # Definição de metadados e dependências do projeto
└── README.md
```

## ⚙️ Como Começar

Para configurar e executar o projeto localmente, siga as instruções detalhadas abaixo.

### Pré-requisitos

* **Flutter SDK:** Certifique-se de ter o Flutter instalado. Você pode seguir o [guia oficial de instalação](https://docs.flutter.dev/get-started/install).
* **Um editor de código:** VS Code, Android Studio ou IntelliJ.
* **Um emulador ou dispositivo físico:** Um emulador Android/iOS ou um dispositivo conectado para executar o app.

### Instalação

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/jhonsoad/projeto-financeiro-android-app.git](https://github.com/jhonsoad/projeto-financeiro-android-app.git)
    ```

2.  **Navegue até o diretório do projeto:**
    ```bash
    cd projeto-financeiro-android-app
    ```

3.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```

### Configuração do Firebase (Instruções para Avaliação)

Para que o aplicativo funcione, é necessário conectá-lo a um projeto Firebase. Como os arquivos de configuração contêm chaves de acesso, você precisará criar um projeto gratuito no Firebase para gerar seus próprios arquivos.

Siga os passos abaixo:

#### Parte 1: Criar o Projeto no Firebase

1.  Acesse o [console do Firebase](https://console.firebase.google.com/) com uma conta Google.
2.  Clique em **"Adicionar projeto"** ou **"Criar um projeto"**.
3.  Dê um nome ao projeto (ex: `AvaliacaoByteBank`) e aceite os termos.
4.  Você pode desativar o Google Analytics para este projeto para simplificar a configuração.
5.  Clique em **"Criar projeto"** e aguarde a finalização.

#### Parte 2: Configurar para Android

1.  Na tela principal do seu novo projeto Firebase, clique no ícone do **Android** (`</>`).
2.  No campo **"Nome do pacote Android"**, insira exatamente: `com.example.projeto_financeiro_app_flutter`.
3.  Os outros campos são opcionais. Clique em **"Registrar app"**.
4.  Na etapa seguinte, clique em **"Fazer o download do google-services.json"** para baixar o arquivo de configuração.
5.  **Mova o arquivo `google-services.json` que você baixou para a pasta `android/app/`** na raiz do projeto que você clonou. Se já existir um arquivo com esse nome, substitua-o.
6.  Clique em **"Próxima"** e, em seguida, em **"Continuar no console"**. Você pode ignorar as outras instruções, pois o projeto já está configurado para usar o SDK do Firebase.

#### Parte 3: Ativar os Serviços no Firebase

Para que o login e o armazenamento de dados funcionem, você precisa ativar os seguintes serviços:

1.  **Authentication:**
    * No menu à esquerda, vá para **Build > Authentication**.
    * Clique em **"Primeiros passos"**.
    * Selecione **"E-mail/senha"** na lista de provedores e ative-o.

2.  **Cloud Firestore (Banco de Dados):**
    * No menu, vá para **Build > Cloud Firestore**.
    * Clique em **"Criar banco de dados"**.
    * Selecione **"Iniciar em modo de teste"** (isso permite leitura e escrita sem regras de segurança complexas, ideal para avaliação).
    * Escolha um local para o servidor (pode manter o padrão) e clique em **"Ativar"**.

3.  **Storage (Armazenamento de Arquivos):**
    * No menu, vá para **Build > Storage**.
    * Clique em **"Primeiros passos"**.
    * Selecione **"Iniciar em modo de teste"** para as regras de segurança.
    * Clique em **"Concluído"**.

Após seguir todos esses passos, o projeto estará pronto para ser executado.

### Como Executar

1.  Certifique-se de que um emulador esteja rodando ou que um dispositivo físico esteja conectado.
2.  Execute o seguinte comando no terminal na raiz do projeto:
    ```bash
    flutter run
    ```

A aplicação será compilada e iniciada no dispositivo/emulador selecionado.