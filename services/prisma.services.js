const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient()

async function getProjectInformation(projectId){
    try {
        let project;
        project = await prisma.projects.findUnique({
            where: {id: projectId},
            select: {
                name: true,
                code: true,
                scope: true,
                target: true,
                usecase: true,
                contactPoint: {
                    select: {
                        name: true,
                        email: true,
                    }
                },
                customer: {
                    select: {
                        name: true,
                    }
                },
                product: {
                    select: {
                        name: true,
                    }
                }
            }
        });
        return project
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    getProjectInformation,
}
