package main

import "github.com/posener/complete"

var services = []string{
	"consul",
	"elasticsearch",
	"influxdb",
	"kafka",
	"logspout",
	"postgres",
	"redis",
	"telegraf",
	"vault",
	"zookeeper",
}

func predictServices(_ complete.Args) []string {
	return services
}