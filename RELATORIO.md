# RELATORIO

- ## Desenvolvimento técnico  (3,0 pts)
  - ### Algum mecanismo de persistência?

    Foi desenvolvido uma API REST para cadastro de tarefas, que possui as seguintes rotas:
    OBS: Dia deve estar no formato YY-MM-DD

    #### Listar todas as tarefas.
    ```
    get "/tasks
    ```
    #### Listar todas as tarefas de um determinado dia.
    ```
    get "/tasks/:day"
    ```

    #### Cadastrar tarefas de um determinado dia
    ```
      post "/tasks/:day"
    ```

    #### Atualizar tarefas de um determinado dia
    ```
    put "/tasks/:day"
    ```

    #### Excluir tarefas de um determinado dia
    ```
    delete "/tasks/:day"
    ```

    Todas as rotas possuem validação para dias e tarefas. Infelizmente, não foi possível utilizar um banco de dados como mecanismo de persistência, então, os dados estão sendo armazenados em memória (variável global mutável), utilizando o mecanismo de persistência MVar.

  - ### Utilizou Recursos avançados da linguagem? (Elm ou Haskell)
    Foram utilizadas Mônadas durante o desenvolvimento do backend para tratar operações com IO.
  - ### Rotas? Tasks e Subscribers em Elm?
  - ### Criou tipos Union types?
    Sim, foram criados, principalmente na função update type Msg
    ```
    update msg m =
        case msg of
            Add title ->
                { m
                    | content =
                        { id = (List.length m.content)
                        , title = title
                        }
                            :: m.content
                    , titleInput = ""
                }

            Remove id ->
                { m
                    | content = List.filter (\item -> item.id /= id) m.content
                }

            ChangeInputText text ->
                { m
                    | titleInput = text
                }

            Clear ->
                { content = []
                , titleInput = "" }
    ```
    ```
    type Msg
        = Add String
        | ChangeInputText String
        | Remove Int
        | Clear
    ```

  - ### Instanciou alguma classe explicitamente em Haskell?
    Não foi necessário para este projeto.
- ## Qualidade do Produto  (3,0 pts)
   - ### Ignorando a aparência, implementa recursos básicos esperados?
     Foram Implementados os recursos básicos de uma lista de tarefas, incluindo adicionar tarefas, limpar lista de tarefas e excluir tarefa (marcar como concluída);
   - ### Implementa interações de forma eficiente?
     As interações com cliente foram implementadas de modo a facilitar a utilização do usuário. Na página de tarefas, temos dois botões, um botão para adicionar tarefa e outro para limpar a lista de tarefas. Existe um campo para adicionar tarefas, bastando escrever o nome da tarefa e clicar no botão de adicionar. Para remover uma tarefa, basta clicar sobre a tarefa.
   - ### Conseguiu polir a aplicação?
     O frontend da aplicação foi melhorado, utilizando materialize. Páginas HTML adicionais foram desenvolvidas para melhorar a apresentação do produto. O Javascript gerado foi integrado ao HTML;
   - ### Pronto para produção?
     O App já está em produção e pode ser acessado por meio do link https://fga-funcional.github.io/Todo/
- ## Integração front + back   (2,5 pts)
  - ### Front usa backend como mecanismo de persistência?
    Infelizmente não foi possível realizar a integração entre a aplicação Elm e a API.
  - ### Conseguiu conectar os dois sistemas adequadamente?
    Não.
  - ### Consegue rodar mais de uma instâcia (discriminada por URL, por exemplo)
    Não.

- ## Método (1,5 pts)
   - ### Possui sistema de build?
     Para realizar o build do projeto, basta rodar o comando elm make ```src/Main.elm --output ../elm.js```. Já existe um arquivo HTML que realiza a importação do script, então, basta abrir esse arquivo com o browser de preferência. Tentou-se implementar um sistema de build com Docker para preparar todo o ambiente, instalando todas as dependências, porém, não obteve-se sucesso.
   - ### Testes unitários e boas práticas?
     Este projeto não possui testes unitários, porém, boas práticas de programação foram aplicadas, como a modularização, onde se dividiu a aplicação em vários arquivos (Main, Models, Msgs, Views). Além disso, foram utilizados nomes significativos, atomicidade nas funções e comentários documentando os métodos da API.
   - ### Implantou em algum lugar?
     O App foi implantando utilizando o github pages e pode ser acessado por meio do link https://fga-funcional.github.io/Todo/
