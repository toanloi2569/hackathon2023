/*
  Warnings:

  - The `industry` column on the `customer_oganizations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `roleId` on the `project_members` table. All the data in the column will be lost.
  - You are about to drop the column `grade` on the `projects` table. All the data in the column will be lost.
  - The `department` column on the `users` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the `contact_point` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `project_evaluation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `timeline` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `value` to the `activities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `contracts` table without a default value. This is not possible if the table is not empty.
  - Made the column `url` on table `contracts` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `subject` to the `issues` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `issues` table without a default value. This is not possible if the table is not empty.
  - Added the required column `milestoneDate` to the `milestones` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pic_id` to the `milestones` table without a default value. This is not possible if the table is not empty.
  - Added the required column `status` to the `milestones` table without a default value. This is not possible if the table is not empty.
  - Added the required column `subject` to the `milestones` table without a default value. This is not possible if the table is not empty.
  - Added the required column `contactPointId` to the `projects` table without a default value. This is not possible if the table is not empty.
  - Added the required column `productId` to the `projects` table without a default value. This is not possible if the table is not empty.
  - Made the column `customerId` on table `projects` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `type` to the `timeline_states` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "contact_point" DROP CONSTRAINT "contact_point_customerId_fkey";

-- DropForeignKey
ALTER TABLE "project_evaluation" DROP CONSTRAINT "project_evaluation_projectId_fkey";

-- DropForeignKey
ALTER TABLE "project_members" DROP CONSTRAINT "project_members_roleId_fkey";

-- DropForeignKey
ALTER TABLE "projects" DROP CONSTRAINT "projects_customerId_fkey";

-- DropForeignKey
ALTER TABLE "timeline" DROP CONSTRAINT "timeline_projectId_fkey";

-- DropForeignKey
ALTER TABLE "timeline_states" DROP CONSTRAINT "timeline_states_timelineId_fkey";

-- AlterTable
ALTER TABLE "activities" ADD COLUMN     "current_status" TEXT,
ADD COLUMN     "next_plan" TEXT,
ADD COLUMN     "value" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "contracts" DROP COLUMN "type",
ADD COLUMN     "type" TEXT NOT NULL,
ALTER COLUMN "url" SET NOT NULL;

-- AlterTable
ALTER TABLE "customer_oganizations" ADD COLUMN     "contactPointsId" TEXT,
DROP COLUMN "industry",
ADD COLUMN     "industry" TEXT,
ALTER COLUMN "size" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "issues" ADD COLUMN     "closedDate" TIMESTAMP(3),
ADD COLUMN     "correctiveAction" TEXT,
ADD COLUMN     "criticalLevel" TEXT,
ADD COLUMN     "description" TEXT,
ADD COLUMN     "dueDate" TIMESTAMP(3),
ADD COLUMN     "impact" TEXT,
ADD COLUMN     "preventiveAction" TEXT,
ADD COLUMN     "rootCause" TEXT,
ADD COLUMN     "startDate" TIMESTAMP(3),
ADD COLUMN     "status" TEXT,
ADD COLUMN     "subject" TEXT NOT NULL,
ADD COLUMN     "type" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "milestones" ADD COLUMN     "description" TEXT,
ADD COLUMN     "milestoneDate" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "pic_id" TEXT NOT NULL,
ADD COLUMN     "result" TEXT,
ADD COLUMN     "status" TEXT NOT NULL,
ADD COLUMN     "subject" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "project_members" DROP COLUMN "roleId";

-- AlterTable
ALTER TABLE "projects" DROP COLUMN "grade",
ADD COLUMN     "contactPointId" TEXT NOT NULL,
ADD COLUMN     "productId" TEXT NOT NULL,
ADD COLUMN     "sharepointLink" TEXT,
ALTER COLUMN "customerId" SET NOT NULL;

-- AlterTable
ALTER TABLE "timeline_states" ADD COLUMN     "type" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "department",
ADD COLUMN     "department" TEXT;

-- DropTable
DROP TABLE "contact_point";

-- DropTable
DROP TABLE "project_evaluation";

-- DropTable
DROP TABLE "timeline";

-- DropEnum
DROP TYPE "ENUM_CONTRACT_TYPE";

-- DropEnum
DROP TYPE "ENUM_DEPARTMENT";

-- DropEnum
DROP TYPE "ENUM_INDUSTRY";

-- DropEnum
DROP TYPE "ENUM_TIMELINE_TYPE";

-- CreateTable
CREATE TABLE "contact_points" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "phoneNumber" TEXT,
    "customerOganizationId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "contact_points_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "project_evaluations" (
    "id" TEXT NOT NULL,
    "evaluation_link" TEXT,
    "process_score" DOUBLE PRECISION,
    "time_score" DOUBLE PRECISION,
    "customer_satisfaction_score" DOUBLE PRECISION,
    "grade" TEXT,
    "comment" TEXT,
    "projectId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "project_evaluations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "timelines" (
    "id" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "projectId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "timelines_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bot_links" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "projectId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "bot_links_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "moms" (
    "id" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "content_link" TEXT,
    "projectId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "moms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "implementations" (
    "id" TEXT NOT NULL,
    "uat_confirm" BOOLEAN NOT NULL,
    "testcase_report" TEXT NOT NULL,
    "testcase_link" TEXT,
    "projectId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "implementations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tasks" (
    "id" TEXT NOT NULL,
    "subject" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "pic_id" TEXT NOT NULL,
    "project_id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "tasks_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "contact_points_customerOganizationId_key" ON "contact_points"("customerOganizationId");

-- CreateIndex
CREATE UNIQUE INDEX "project_evaluations_projectId_key" ON "project_evaluations"("projectId");

-- AddForeignKey
ALTER TABLE "contact_points" ADD CONSTRAINT "contact_points_customerOganizationId_fkey" FOREIGN KEY ("customerOganizationId") REFERENCES "customer_oganizations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "projects" ADD CONSTRAINT "projects_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customer_oganizations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "projects" ADD CONSTRAINT "projects_contactPointId_fkey" FOREIGN KEY ("contactPointId") REFERENCES "contact_points"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "projects" ADD CONSTRAINT "projects_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_evaluations" ADD CONSTRAINT "project_evaluations_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "timelines" ADD CONSTRAINT "timelines_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "timeline_states" ADD CONSTRAINT "timeline_states_timelineId_fkey" FOREIGN KEY ("timelineId") REFERENCES "timelines"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bot_links" ADD CONSTRAINT "bot_links_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "moms" ADD CONSTRAINT "moms_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "implementations" ADD CONSTRAINT "implementations_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_pic_id_fkey" FOREIGN KEY ("pic_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "milestones" ADD CONSTRAINT "milestones_pic_id_fkey" FOREIGN KEY ("pic_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
