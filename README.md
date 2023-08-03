# Dependencies

Install node=18.15.0 and yarn
```angular2html=
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
nvm install 18.15.0
nvm use 18.15.0
npm install -g yarn
```

# Installation

```angular2html=
yarn install
```

# Migrate Database
After update prisma schema in `prisma/schema.prisma`, run the following command to migrate database.

```angular2html=
export DATABASE_URL="postgres://<USER>:<PASSWORD>@<HOST>:<PORT>/postgres?schema=public"
npx prisma migrate dev --name <migration-name>
```
