variable "tag" {
  default = "session-manager-test"
}

variable "subnets" {
  default = {
    "ap-northeast-1a" = 1
    "ap-northeast-1c" = 2
  }
}
