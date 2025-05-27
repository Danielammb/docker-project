FROM node:20-alpine AS build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build
RUN npm install --omit=dev 
# npm install com flag --omit=dev vai instalar apenas os pacotes necessários

FROM node:20-alpine

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/package*.json ./
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules
EXPOSE 3000

CMD ["npm", "run", "start:prod"]

# Comandos para criar uma imagem e em sequência executar o container:
# docker build -t <nome da imagem> .

# Listar imagens criadas:
# docker image ls <nome da imagem>

# Criar/nomear/associar-volume/conectar-rede e executar o container criado a partir da imagem:
# docker run --name nome_container -volume <nome do volume>:<local do volume> --network minharede -p 3000:3000 -d <nome da imagem>

# Listar containers em execucão:
# docker container ls ou docker ps

# Parar o container rodando:
# docker stop <id do container>

# Rodar o container novamente:
# docker start <id do container>

# Sobre Docker Volumes:
  # Volumes sao arquivos locais que o container pode acessar e manipular. Porém, existe casos de usos e um container nem sempre precisar ter um volume.
  # Para criar um volume, basta executar o comando: docker volume create <nome do volume>