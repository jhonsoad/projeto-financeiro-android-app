ByteBank App (Projeto Financeiro Flutter)
🎯 Sobre o Projeto
Este repositório contém o aplicativo de gerenciamento financeiro ByteBank, desenvolvido em Flutter. O objetivo do projeto é fornecer uma experiência móvel completa para controle de finanças pessoais, integrando-se com os serviços do Firebase para autenticação e armazenamento de dados em tempo real.

A aplicação foi projetada para ser modular e escalável, utilizando o provider para um gerenciamento de estado limpo e centralizado.

✨ Funcionalidades
As responsabilidades principais do aplicativo incluem:

Autenticação de Usuários: Sistema completo de cadastro e login utilizando Firebase Authentication (Email e Senha).

Dashboard Financeiro: Tela principal com resumo de saldo, cartões e acesso rápido às funcionalidades.

Gerenciamento de Transações:

Visualização de extrato detalhado com transações recentes.

Criação de novas transações (depósito e transferência), com opção de anexar comprovantes (upload de imagem para o Firebase Storage).

Edição e exclusão de transações existentes.

Filtros: Possibilidade de filtrar o extrato por categoria (tipo de transação) e por data.

Visualização de Gráficos: Seção de investimentos com um gráfico de pizza para análise de despesas por categoria.

🏛️ Arquitetura e Tecnologias
A arquitetura do projeto segue as melhores práticas de desenvolvimento Flutter, com uma clara separação de responsabilidades.

Tecnologias Principais:

Flutter: Framework principal para o desenvolvimento de aplicações multiplataforma (Android, iOS, Web, etc.).

Dart: Linguagem de programação utilizada pelo Flutter.

Firebase: Plataforma utilizada para backend as a service:

Firebase Authentication: Para cadastro e login de usuários.

Cloud Firestore: Como banco de dados NoSQL em tempo real para armazenar transações.

Firebase Storage: Para armazenamento de arquivos, como comprovantes de transações.

Provider: Para gerenciamento de estado declarativo e centralizado.

intl: Para formatação de datas e valores monetários.

fl_chart: Para a criação de gráficos dinâmicos na seção de investimentos.

⚙️ Como Começar
Siga estas instruções para configurar e executar o projeto localmente.

Pré-requisitos
Flutter SDK: Guia de instalação do Flutter

Um editor de código: VS Code (com a extensão do Flutter) ou Android Studio.

Um emulador Android/iOS ou um dispositivo físico.

Instalação
Clone este repositório:

Bash

git clone <url-do-seu-repositorio>
Navegue até o diretório do projeto:

Bash

cd projeto-financeiro-android-app
Instale as dependências:

Bash

flutter pub get
Configuração do Firebase
Para que o aplicativo se conecte ao seu projeto Firebase, é necessário adicionar os arquivos de configuração.

Crie um projeto no Firebase Console.

Adicione um aplicativo Android e um aplicativo iOS ao seu projeto Firebase.

Siga as instruções para baixar os arquivos de configuração:

Para Android:

Baixe o arquivo google-services.json.

Coloque este arquivo no diretório android/app/.

Para iOS:

Baixe o arquivo GoogleService-Info.plist.

Abra o diretório ios/Runner.xcworkspace no Xcode e arraste o arquivo GoogleService-Info.plist para dentro da pasta Runner (certifique-se de que a opção "Copy items if needed" esteja marcada).

No console do Firebase, ative os seguintes serviços:

Authentication: Vá para a aba "Authentication", clique em "Get Started" e ative o provedor de "E-mail/senha".

Firestore Database: Vá para a aba "Firestore Database", clique em "Criar banco de dados" e inicie no modo de teste.

Storage: Vá para a aba "Storage", clique em "Get Started" e siga as instruções, mantendo as regras de segurança padrão para desenvolvimento.

Como Executar
Após a instalação e configuração, execute o seguinte comando para iniciar o aplicativo em seu emulador ou dispositivo conectado:

Bash

flutter run