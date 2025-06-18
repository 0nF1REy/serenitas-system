# 📦 Serenitas System

![Status](https://img.shields.io/badge/status-Conclu%C3%ADdo-brightgreen)
![Java](https://img.shields.io/badge/Java-8%2B-blue.svg)
![Build](https://img.shields.io/badge/build-Apache%20Ant-red.svg)
![Platform](https://img.shields.io/badge/platform-Web-lightgrey.svg)
![Database](https://img.shields.io/badge/database-MySQL-orange.svg)
![Tomcat](https://img.shields.io/badge/server-Tomcat-yellow.svg)
![Contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

![Maintained](https://img.shields.io/maintenance/yes/2025?style=for-the-badge)

## 📖 Descrição

Este repositório abriga o "Serenitas System", um sistema web para gestão de produtos. O projeto foi desenvolvido para simplificar e otimizar o controle de estoque e informações de produtos, oferecendo funcionalidades como cadastro, listagem, alteração, exclusão e importação via CSV. O sistema utiliza tecnologias como Java, JSP, MySQL e Apache Tomcat, criando uma solução completa para gerenciamento de produtos.

Os principais recursos incluem:

*   **Criação de Produto:** Adicione novos produtos ao sistema com facilidade.
*   **Listagem de Produtos:** Visualize uma lista completa de todos os produtos.
*   **Atualização de Produto:** Modifique as informações dos produtos existentes.
*   **Exclusão de Produto:** Remova produtos do sistema.
*   **Importação CSV:** Importe dados de produtos em massa por meio de arquivos CSV.

## ✨ Funcionalidades

*   Interface web amigável ao usuário.
*   Funcionalidades completas para gerenciamento de produtos.
*   Integração com banco de dados para armazenamento persistente.
*   Importação CSV para entrada eficiente de dados.

## 📸 Capturas de Tela

*   ### *Apresentação:*

<img src="./readme_assets/pagina-principal.png" alt="Apresentação"/>

*   ### *Cadastro de Produtos:*

<img src="./readme_assets/cadastro-de-produtos.png" alt="Cadastro de Produtos"/>

*   ### *Listagem de Produtos:*

<img src="./readme_assets/listagem-de-produtos.png" alt="Listagem de Produtos"/>

*   ### *Consultar Produtos:*

<img src="./readme_assets/consultar-produtos.png" alt="Consultar Produtos"/>

*   ### *Cadastrar via CSV:*

<img src="./readme_assets/cadastrar-via-csv.png" alt="Consultar via CSV"/>

## 🚀 Começando

Os seguintes softwares precisam estar instalado em seu sistema antes de você poder executar o Serenitas System:

<div align="center">

## Pré-requisitos

<a href="https://git-scm.com/" target="_blank">
  <img src="./readme_assets/git-logo.png" width="200" alt="Git Logo" />
</a>
<a href="https://ant.apache.org/" target="_blank">
  <img src="./readme_assets/apache-ant-logo.png" width="200" alt="Apache Ant Logo" />
</a>
<a href="https://www.oracle.com/java/" target="_blank">
  <img src="./readme_assets/java-jdk-logo.png" width="200" alt="Java JDK Logo" />
</a>
<a href="https://www.mysql.com/" target="_blank">
  <img src="./readme_assets/mysql-logo.png" width="200" alt="MySQL Logo" />
</a>
<a href="https://tomcat.apache.org/" target="_blank">
  <img src="./readme_assets/apache-tomcat-logo.png" width="200" alt="MySQL Logo" />
</a>

</div>

*   **Git:** Para clonar o repositório. [https://git-scm.com/](https://git-scm.com/)
*   **Apache Ant:** Para compilar o projeto. [https://ant.apache.org/](https://ant.apache.org/)
*   **Java JDK:** Kit de Desenvolvimento Java 8 ou superior. [https://www.oracle.com/java/](https://www.oracle.com/java/)
*   **MySQL:** Servidor MySQL. [https://www.mysql.com/](https://www.mysql.com/)
*   **Apache Tomcat:** Contêiner de Servlets para executar a aplicação. [https://tomcat.apache.org/](https://tomcat.apache.org/)


---

### 📦 Instalação

Para executar o **Serenitas System** localmente, siga estes passos:

1.  **Clone o repositório:**

    ```bash
    git clone https://github.com/0nF1REy/serenitas-system.git
    ```

2.  **Entre no diretório:**

    ```bash
    cd serenitas-system
    ```

3.  **Importe o banco de dados:** 

    ```bash
    # Exemplo com MySQL:
    mysql -u root -p < database/serenitas.sql
    ```

4.  **Configure a conexão com o banco de dados**

    No arquivo de configuração **.env** localizado na pasta **web/**, ajuste as variáveis de ambiente para conectar ao seu banco de dados **MySQL**. Exemplo de conteúdo do arquivo **.env**:

    ```bash
    # URL de conexão com o banco de dados MySQL
    DB_URL=jdbc:mysql://localhost:3306/serenitas_db

    # Usuário do banco de dados
    DB_USER=root

    # Senha do banco de dados
    DB_PASSWORD=verysecret
    ```

5.  **Compilar e Empacotar o Projeto:** 

    ```bash
    ant clean dist
    ```

6.  **Determinar o caminho do webapps:** 

    ```bash
    # Exemplo para Arch Linux:
    pacman -Ql tomcat10 | grep webapps

    # Exemplo para Debian/Ubuntu:
    dpkg -L tomcat10 | grep webapps

    # Exemplo para Fedora/CentOS/RHEL/openSUSE e Mageia:
    rpm -ql tomcat | grep webapps

    # Exemplo para Alpine Linux:
    apk info -q tomcat* --files | grep webapps

    # Exemplo para Gentoo:
    equery files tomcat | grep webapps

    # Exemplo para Void Linux:
    xbps-query -f tomcat | grep webapps

    # Exemplo para Amazon Linux:
    rpm -ql tomcat | grep webapps
    ```

7.  **Implantar o WAR no Tomcat:** 

    ```bash
    # Copie serenitas-system.war para o diretório webapps do Tomcat.
    sudo cp dist/serenitas-system.war /var/lib/tomcat10/webapps/
    ```    

8.  **Reiniciar e iniciar o Tomcat:** 

    ```bash
    sudo systemctl stop tomcat10
    sudo systemctl start tomcat10
    ```

9. **Acesse a aplicação no navegador:**

    ```
    http://localhost:8080/serenitas-system/
    ```
    
---

<div align="center">

## Autor 🧑🛡️ 
  <table>
  <tr>
    <td align="center">
      <a href="https://github.com/0nF1REy" target="_blank">
        <img src="./readme_assets/alan-ryan.jpg" height="160px;" alt="Foto de Alan Ryan"/><br>
          <b>Alan Ryan</b>  
      </a>
    </td>
  </tr>
</table>
</div>

## 🤝 Contribuindo

Contribuições são bem-vindas! Se você deseja contribuir com o projeto, siga estes passos:

1.  **Faça um fork** do repositório.

2.  **Crie uma branch** para sua funcionalidade ou correção de bug:

    ```bash
    git checkout -b feature/sua-funcionalidade
    ```

3.  **Faça suas alterações**.

4.  **Realize o commit das suas alterações:**

    ```bash
    git commit -m "Adiciona sua funcionalidade ou correção"
    ```

5.  **Envie para o seu repositório forkado:**

    ```bash
    git push origin feature/sua-funcionalidade
    ```

6.  **Abra um pull request** para a branch `main` do projeto original.

### Recursos Úteis

- **<a href="https://www.atlassian.com/br/git/tutorials/making-a-pull-request" target="_blank">📝 Como criar uma solicitação pull</a>**

- **<a href="https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716" target="_blank">💾 Padrão de commit</a>**

## 📜 Licença

Este projeto está sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para obter mais detalhes.