-- CreateTable
CREATE TABLE "accounts" (
    "id" SERIAL NOT NULL,
    "username" VARCHAR(40) NOT NULL,
    "firstanme" VARCHAR(40) NOT NULL,
    "lastName" VARCHAR(40) NOT NULL,
    "email" VARCHAR(50) NOT NULL,
    "emailVerified" BOOLEAN NOT NULL DEFAULT false,
    "enabled" VARCHAR(30) NOT NULL,
    "createdTimestamp" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "areas" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "icon" VARCHAR(30) NOT NULL,
    "color" VARCHAR(10) NOT NULL,
    "properties_id" INTEGER NOT NULL,

    CONSTRAINT "areas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categories" (
    "id" SERIAL NOT NULL,
    "categoryName" VARCHAR(30) NOT NULL,
    "categoryIcon" VARCHAR(30) NOT NULL,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "devices" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(30) NOT NULL,
    "description" VARCHAR(50) NOT NULL,
    "image_url" VARCHAR(255) NOT NULL,
    "brand" VARCHAR(30) NOT NULL,
    "model" VARCHAR(30) NOT NULL,
    "categories_id" INTEGER NOT NULL,
    "type" VARCHAR(30) NOT NULL,
    "spec" JSONB NOT NULL,

    CONSTRAINT "devices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "events" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(30) NOT NULL,
    "description" VARCHAR(30) NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "events_type_id" INTEGER NOT NULL,

    CONSTRAINT "events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "events_type" (
    "id" SERIAL NOT NULL,
    "type" VARCHAR(30) NOT NULL,

    CONSTRAINT "events_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notifications" (
    "id" SERIAL NOT NULL,
    "content" TEXT NOT NULL,
    "notifications_type_id" INTEGER NOT NULL,
    "users_profiles_id" INTEGER NOT NULL,

    CONSTRAINT "notifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notifications_type" (
    "id" SERIAL NOT NULL,
    "type" VARCHAR(50) NOT NULL,

    CONSTRAINT "notifications_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments" (
    "id" SERIAL NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "payment_method" VARCHAR(50) NOT NULL,
    "transaction_id" VARCHAR(500) NOT NULL,
    "subscriptions_id" INTEGER NOT NULL,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "properties" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(30) NOT NULL,
    "image_url" VARCHAR(255) NOT NULL,
    "address" VARCHAR(100) NOT NULL,
    "events_id" INTEGER NOT NULL,
    "users_profiles_id" INTEGER NOT NULL,

    CONSTRAINT "properties_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "subscriptions" (
    "id" SERIAL NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,
    "subscription_plans_id" INTEGER NOT NULL,
    "users_profiles_id" INTEGER NOT NULL,

    CONSTRAINT "subscriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "subscriptions_plans" (
    "id" SERIAL NOT NULL,
    "subscription_plan" VARCHAR(50) NOT NULL,

    CONSTRAINT "subscriptions_plans_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users_devices" (
    "devices_id" INTEGER NOT NULL,
    "areas_id" INTEGER NOT NULL,
    "users_profiles_id" INTEGER NOT NULL,

    CONSTRAINT "users_devices_pkey" PRIMARY KEY ("devices_id","areas_id","users_profiles_id")
);

-- CreateTable
CREATE TABLE "users_profiles" (
    "id" SERIAL NOT NULL,
    "phone" VARCHAR(9) NOT NULL,
    "dni" VARCHAR(8) NOT NULL,
    "photo_url" VARCHAR(255) NOT NULL,
    "occupation" VARCHAR(30) NOT NULL,
    "accounts_id" INTEGER NOT NULL,

    CONSTRAINT "users_profiles_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "areas" ADD CONSTRAINT "areas_properties_id_fkey" FOREIGN KEY ("properties_id") REFERENCES "properties"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "devices" ADD CONSTRAINT "devices_categories_id_fkey" FOREIGN KEY ("categories_id") REFERENCES "categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_events_type_id_fkey" FOREIGN KEY ("events_type_id") REFERENCES "events_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_notifications_type_id_fkey" FOREIGN KEY ("notifications_type_id") REFERENCES "notifications_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_users_profiles_id_fkey" FOREIGN KEY ("users_profiles_id") REFERENCES "users_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_subscriptions_id_fkey" FOREIGN KEY ("subscriptions_id") REFERENCES "subscriptions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "properties" ADD CONSTRAINT "properties_events_id_fkey" FOREIGN KEY ("events_id") REFERENCES "events"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "properties" ADD CONSTRAINT "properties_users_profiles_id_fkey" FOREIGN KEY ("users_profiles_id") REFERENCES "users_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_subscription_plans_id_fkey" FOREIGN KEY ("subscription_plans_id") REFERENCES "subscriptions_plans"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_users_profiles_id_fkey" FOREIGN KEY ("users_profiles_id") REFERENCES "users_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_devices" ADD CONSTRAINT "users_devices_devices_id_fkey" FOREIGN KEY ("devices_id") REFERENCES "devices"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_devices" ADD CONSTRAINT "users_devices_areas_id_fkey" FOREIGN KEY ("areas_id") REFERENCES "areas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_devices" ADD CONSTRAINT "users_devices_users_profiles_id_fkey" FOREIGN KEY ("users_profiles_id") REFERENCES "users_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_profiles" ADD CONSTRAINT "users_profiles_accounts_id_fkey" FOREIGN KEY ("accounts_id") REFERENCES "accounts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
