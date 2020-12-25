variable "private" {
  type = map
  default = {
    "token"  = "ENTER YOUR TOKEN"
    "cloud_id" = "ENTER YOUR CLOUDID"
    "folder_id" = "ENTER YOUR FOLDERID"
  }
}

variable "img" {
  type = map
  default = {
    "ub1604lts" = "fd87va5cc00gaq2f5qfb"
    "ub1804lts" = "fd83bj827tp2slnpp7f0"
  }
}

variable "zone" {
  type = map
  default = {
    "1" = "ru-central1-a"
    "2" = "ru-central1-b"
    "3" = "ru-central1-c"
  }
}
