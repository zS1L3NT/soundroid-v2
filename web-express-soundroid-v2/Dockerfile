FROM node:16

WORKDIR /home/web-express-soundroid-v2

COPY . .

RUN npm i -g pnpm
RUN pnpm i
RUN pnpm build

EXPOSE 5190
CMD ["pnpm", "start"]