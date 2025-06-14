<%@ page import="io.github.cdimascio.dotenv.Dotenv" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Cadastro via CSV</title>
    <link rel="stylesheet" href="./styles/csv.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body>
<div class="csv-console">
<%
try {
    Dotenv dotenv = Dotenv.configure()
            .directory(application.getRealPath("/"))
            .load();

    String url = dotenv.get("DB_URL");
    String user = dotenv.get("DB_USER");
    String password = dotenv.get("DB_PASSWORD");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexao = DriverManager.getConnection(url, user, password);

    String path = application.getRealPath("/tb_produto.csv");
    FileReader arquivo = new FileReader(path);
    BufferedReader br = new BufferedReader(arquivo);

    String sql = "INSERT INTO tb_produto (nome, marca, preco) VALUES (?, ?, ?)";
    PreparedStatement st = conexao.prepareStatement(sql);

    String linha = br.readLine(); // pula o cabeçalho

    List<String> nomesProdutos = new ArrayList<>();
    List<String> linhasInvalidas = new ArrayList<>();

    while ((linha = br.readLine()) != null) {
        String[] dados = linha.split(",");
        if (dados.length < 3) {
            linhasInvalidas.add(linha);
            continue;
        }

        try {
            String n = dados[0];
            String m = dados[1];
            BigDecimal p = new BigDecimal(dados[2].trim());

            st.setString(1, n);
            st.setString(2, m);
            st.setBigDecimal(3, p);
            st.addBatch();

            nomesProdutos.add(n);

        } catch (Exception ex) {
            linhasInvalidas.add(linha);
        }
    }

    int[] resultados = st.executeBatch();

    br.close();
    st.close();
    conexao.close();

    if (resultados.length <= 10) {
        // Mostrar mensagem individual para cada produto
        for (String nome : nomesProdutos) {
            out.println("<span class='sucesso'>Produto '" + nome + "' cadastrado com sucesso.</span><br>");
        }
    } else {
        // Mostrar mensagem geral para muitos produtos com opção de ver detalhes
        out.println("<span class='sucesso'>Cadastro concluído: " + resultados.length + " produtos inseridos com sucesso.</span><br>");

        // Botão toggle para mostrar/ocultar detalhes
        out.println("<span class='log-toggle' onclick='toggleLog()' id='toggleBtn'>");
        out.println("<i class='fa-solid fa-plus'></i> Ver detalhes do cadastro");
        out.println("</span>");

        out.println("<div id='logDetalhes' style='display:none; margin-top:10px;'>");
        for (String nome : nomesProdutos) {
            out.println("<span class='sucesso'>Produto '" + nome + "' cadastrado com sucesso.</span><br>");
        }
        out.println("</div>");
    }

    if (!linhasInvalidas.isEmpty()) {
        out.println("<span class='linha-invalida'>Linhas inválidas não inseridas !</span><br>");
        for (String invalida : linhasInvalidas) {
            out.println("<span class='linha-invalida'>" + invalida + "</span><br>");
        }
    }

} catch (Exception e) {
    out.println("<span class='erro'>Erro: " + e.getMessage() + "</span><br>");
    java.io.StringWriter sw = new java.io.StringWriter();
    java.io.PrintWriter pw = new java.io.PrintWriter(sw);
    e.printStackTrace(pw);
    out.println("<pre>" + sw.toString() + "</pre>");
}
%>
</div>

<script>
function toggleLog() {
    var logDiv = document.getElementById('logDetalhes');
    var toggleBtn = document.getElementById('toggleBtn');
    if (logDiv.style.display === 'none' || logDiv.style.display === '') {
        logDiv.style.display = 'block';
        toggleBtn.innerHTML = '<i class="fa-solid fa-minus"></i> Ocultar detalhes do cadastro';
    } else {
        logDiv.style.display = 'none';
        toggleBtn.innerHTML = '<i class="fa-solid fa-plus"></i> Ver detalhes do cadastro';
    }
}
</script>

</body>
</html>
