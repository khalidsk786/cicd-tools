variable "project" {
    default = "expense"

}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        project = "expense"
        environment = "dev"
        terraform = "true"
    }
}

variable "zone_id" {
    default = "Z10448593MELWNQ89OC76"
}