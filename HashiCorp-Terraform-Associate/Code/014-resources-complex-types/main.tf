terraform {
  # local provider
}

# Collection Types
variable "planets" {
  type = list
  default = ["mars", "earth", "moon"]
}

variable "plans" {
  type = map
  default = {
    "PlanA" = "$10",
    "PlanB" = "$20",
    "PlanC" = "$30",
  }
}

# Structural Types

variable "plans_object" {

    # schema
  type = object({
    PlanName = string
    PlanAmount = number

  })

  default = {
    "PlanName" = "Basic"
    "PlanAmount" = 100
  }
}

# Tuple:
variable "plans_tuple" {
  type = tuple([string, number, string, bool])
  default = ["kunal", 20, "eggs", false]
}