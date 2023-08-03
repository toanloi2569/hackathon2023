# Dependencies

Install npm=9.5.0 and node=18.15.0
```angular2html=
npm install -g npm@9.5.0        #npm 9.5.0 
npm install -g node@18.15.0     #node 18.15.0
```

# Installation

```angular2html=
npm install
```

# Migrate Database
After update prisma schema in `prisma/schema.prisma`, run the following command to migrate database.

```angular2html=
export DATABASE_URL="postgres://<USER>:<PASSWORD>@<HOST>:<PORT>/postgres?schema=public"
npx prisma migrate dev --name <migration-name>
```
