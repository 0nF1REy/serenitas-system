FROM tomcat:10.1-jdk17

LABEL maintainer="Alan Ryan da Silva Domingues"

# Copia o WAR compilado para o Tomcat
COPY dist/serenitas.war /usr/local/tomcat/webapps/serenitas.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
