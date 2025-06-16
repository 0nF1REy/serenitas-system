# Serenitas System
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Status](https://img.shields.io/badge/status-Conclu%C3%ADdo-brightgreen)

<ul>
  <li><h3><i>Página principal do projeto:</i></h3></li>
</ul>

<img src="./readme_assets/pagina-principal.png" alt="Página principal do projeto: serenitas-system"/>

## 🚀 Começando

<div align="center">

### Pré-requisitos

<img src="./readme_assets/git-logo.png" width="200" alt="Git Logo" />

- Java JDK 8 ou superior
- [Apache Ant](https://ant.apache.org/)
- [Apache Tomcat 9 ou 10](https://tomcat.apache.org/)
- MySQL / MariaDB
- Editor como VS Code, NetBeans ou IntelliJ

</div>

---

## 📦 Instalação

Para executar localmente, siga os seguintes passos:

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

4. **Verifique onde o Tomcat está instalado:**

    ```bash
    # No Arch Linux (exemplo):
    pacman -Ql tomcat10 | grep webapps
    ```

    ```bash
    # No Ubuntu/Debian (exemplo):
    dpkg -L tomcat9 | grep webapps
    ```

    O resultado deve mostrar o caminho do diretório `webapps` do Tomcat, algo como:

    ```
    tomcat10 /var/lib/tomcat10/webapps/
    ```

5. **Copie a pasta `web` do projeto para o diretório `webapps` do Tomcat:**

    ```bash
    # Execute dentro da pasta do projeto (serenitas-system):
    sudo cp -r ./web /var/lib/tomcat10/webapps/serenitas-system
    ```

6. **Compile o projeto com Apache Ant:**

    ```bash
    ant clean
    ant compile
    ant dist
    ```

7. **Inicie o servidor Tomcat:**

    ```bash
    sudo systemctl start tomcat10
    ```

8. **Acesse a aplicação no navegador:**

    ```
    http://localhost:8080/serenitas-system/
    ```
    
---

## Autor 🧑🛡️ 

<div align="center">
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

## 📫 Contribuir

Se você deseja contribuir com o projeto, siga os seguintes passos:

1. **Faça um fork** do repositório.

2. **Crie uma branch** com a sua funcionalidade:

   ```bash
   git checkout -b feature/minha-funcionalidade
   ```

3. **Faça as alterações necessárias**.

4. **Faça um commit** com suas alterações:

   ```bash
   git commit -m "Adicionado minha funcionalidade"
   ```

5. **Envie para o repositório remoto**:

   ```bash
   git push origin feature/minha-funcionalidade
   ```

6. **Abra um pull request** para a branch `main` do projeto original.

### Documentações úteis

- **<a href="https://www.atlassian.com/br/git/tutorials/making-a-pull-request" target="_blank">📝 Como criar uma solicitação pull</a>**

- **<a href="https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716" target="_blank">💾 Padrão de commit</a>**

## Licença

<a href="./LICENSE" target="_blank"><b>Licença MIT</b></a>