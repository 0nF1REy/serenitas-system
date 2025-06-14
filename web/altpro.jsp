<%@ page import="io.github.cdimascio.dotenv.Dotenv" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Alterar Produto</title>
        <link rel="stylesheet" href="./styles/edit.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    </head>
    <div class="container">
        <body>
            <%
                String id = request.getParameter("id");
                String nomeAntigo = "";
                String nome = "";
                String marca = "";
                String preco = "";
                String mensagem = "";
                boolean alterado = false;
                boolean mostrarFormulario = true; // controle

                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    try {
                        Dotenv dotenv = Dotenv.configure()
                                .directory(application.getRealPath("/"))
                                .load();

                        String url = dotenv.get("DB_URL");
                        String user = dotenv.get("DB_USER");
                        String password = dotenv.get("DB_PASSWORD");

                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, user, password);

                        PreparedStatement psBusca = conn.prepareStatement("SELECT nome, marca, preco FROM tb_produto WHERE id_produto = ?");
                        psBusca.setInt(1, Integer.parseInt(id));
                        ResultSet rsBusca = psBusca.executeQuery();

                        if (rsBusca.next()) {
                            nomeAntigo = rsBusca.getString("nome");
                            String marcaAntiga = rsBusca.getString("marca");
                            BigDecimal precoAntigo = rsBusca.getBigDecimal("preco");

                            String novoNome = request.getParameter("nome");
                            String novaMarca = request.getParameter("marca");
                            BigDecimal novoPreco = new BigDecimal(request.getParameter("preco"));

                            boolean mudou = !novoNome.equals(nomeAntigo)
                                    || !novaMarca.equals(marcaAntiga)
                                    || novoPreco.compareTo(precoAntigo) != 0;

                            if (mudou) {
                                PreparedStatement ps = conn.prepareStatement(
                                        "UPDATE tb_produto SET nome = ?, marca = ?, preco = ?, updated_at = NOW() WHERE id_produto = ?");
                                ps.setString(1, novoNome);
                                ps.setString(2, novaMarca);
                                ps.setBigDecimal(3, novoPreco);
                                ps.setInt(4, Integer.parseInt(id));

                                int linhasAfetadas = ps.executeUpdate();
                                if (linhasAfetadas > 0) {
                                    mensagem = "✅Produto \"" + nomeAntigo + "\" alterado com sucesso!";
                                    alterado = true;
                                    nome = novoNome;
                                } else {
                                    mensagem = "Produto não encontrado.";
                                }
                                ps.close();
                            } else {
                                mensagem = "Nenhuma alteração detectada no produto.";
                                mostrarFormulario = false;
                            }
                        } else {
                            mensagem = "Produto não encontrado para alteração.";
                        }

                        rsBusca.close();
                        psBusca.close();
                        conn.close();
                    } catch (Exception e) {
                        mensagem = "Erro ao alterar produto: " + e.getMessage();
                    }
                } else {
                    try {
                        Dotenv dotenv = Dotenv.configure()
                                .directory(application.getRealPath("/"))
                                .load();

                        String url = dotenv.get("DB_URL");
                        String user = dotenv.get("DB_USER");
                        String password = dotenv.get("DB_PASSWORD");

                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, user, password);

                        PreparedStatement ps = conn.prepareStatement("SELECT nome, marca, preco FROM tb_produto WHERE id_produto = ?");
                        ps.setInt(1, Integer.parseInt(id));
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            nome = rs.getString("nome");
                            marca = rs.getString("marca");
                            preco = rs.getBigDecimal("preco").toString();
                        } else {
                            mensagem = "Produto com ID " + id + " não encontrado.";
                        }

                        rs.close();
                        ps.close();
                        conn.close();
                    } catch (Exception e) {
                        mensagem = "Erro ao buscar produto: " + e.getMessage();
                    }
                }
            %>

            <% if (mostrarFormulario && !alterado) {%>
            <h2>Editando produto: <%= nome%></h2>
            <% } %>

            <% if (!mensagem.isEmpty()) {%>
            <div style="text-align: center; margin: 20px 0;">
                <p class="<%= (alterado ? "success " : "error ") + "styled-message"%>" style="display: inline-block;">
                    <%= mensagem%>
                </p>
            </div>
            <% } %>

            <% if (mostrarFormulario && !alterado) {%>
            <form method="post" action="altpro.jsp?id=<%= id%>">
                <p>
                    <label for="nome">Nome do produto:</label>
                    <input type="text" name="nome" id="nome" value="<%= nome%>" required maxlength="50">
                </p>
                <p>
                    <label for="marca">Marca:</label>
                    <input type="text" name="marca" id="marca" value="<%= marca%>" required maxlength="50">
                </p>
                <p>
                    <label for="preco">Preço (R$):</label>
                    <input type="number" step="0.01" min="0" name="preco" id="preco" value="<%= preco%>" required>
                </p>
                <p>
                    <input type="submit" value="Alterar">
                </p>
            </form>
            <% }%>

            <div class="btn-center">
                <a href="listapro.jsp" class="btn-voltar">
                    <i class="fa-solid fa-arrow-left"></i> Voltar para listagem
                </a>
            </div>
        </body>
</html>
