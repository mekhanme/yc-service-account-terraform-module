// NOTE: https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account
//       https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder_iam_member


resource "yandex_iam_service_account" "sa" {
  name   = var.name
}

resource "yandex_resourcemanager_folder_iam_member" "sa_member" {
  count       = length(var.roles)
  folder_id   = var.folder_id
  member      = "serviceAccount:${yandex_iam_service_account.sa.id}"
  role        = element(var.roles, count.index)
}

resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
  service_account_id   = yandex_iam_service_account.sa.id
}