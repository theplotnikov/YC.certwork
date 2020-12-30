provider "yandex" {
  token     = "${file("~/workspace/cert/var.token")}"
  cloud_id  = "${file("~/workspace/cert/var.cloud_id")}"
  folder_id = "${file("~/workspace/cert/var.folder_id")}"
  zone      = var.zone["1"]
}

resource "yandex_compute_instance" "vm-1" {
  name = "build"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.img["ub1804lts"]
      size = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/workspace/cert/var.pubkey")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name = "deploy"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.img["ub1804lts"]
      size = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/workspace/cert/var.pubkey")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}


resource "yandex_vpc_security_group" "group1" {
  name        = "group1"
  description = "allow web"
  network_id  = "${yandex_vpc_network.network-1.id}"

  labels = {
    my-label = "group1"
}

  ingress {
    protocol       = "ANY"
    description    = "web"
    v4_cidr_blocks = ["192.168.10.0/24"]
    port           = 8080
}

  egress {
    protocol       = "ANY"
    description    = "web"
    v4_cidr_blocks = ["192.168.10.0/24"]
    port           = 8080
  }
}


resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
    vm1-ip = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address,
    vm2-ip = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
    }
    )
    filename = "inventory.yml"
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}