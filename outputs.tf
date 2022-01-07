output "output" {
    description = "alb, http and https listeners attributes "
    value       = {
        alb            = aws_lb.alb
        http_listener  = try(aws_lb_listener.http_listener[0], null)
        https_listener = try(aws_lb_listener.https_listener[0], null)
    }
}
