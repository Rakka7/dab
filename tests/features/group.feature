# vim: ts=4 sw=4 sts=4 noet
Feature: Subcommand: dab group
	The group subcommand manages groups of services, repostories, and tools.

	Background:
		Given the aruba exit timeout is 60 seconds

	Scenario: Can group repossitories then start them together
		Given I successfully run `dab tools stop`
		And I successfully run `dab repo add three https://github.com/Nekroze/dotfiles.git`
		And I successfully run `dab repo add four https://github.com/Nekroze/dotfiles.git`

		When I run `dab group repos work three`

		Then it should pass with "contains 1 value(s)"

		When I run `dab group repos work four`

		Then it should pass with "contains 2 value(s)"

		When I run `dab group start work `

		Then it should pass with:
		"""
		Executing three entrypoint start
		three has no start entrypoint defined
		Executing four entrypoint start
		four has no start entrypoint defined
		"""

	Scenario: Can group repossitories and tools then start them together
		Given I successfully run `dab tools stop`
		And I successfully run `dab repo add five https://github.com/Nekroze/dotfiles.git`
		And I successfully run `dab group repos sidehustle five`

		When I run `dab group tools sidehustle cyberchef`

		Then it should pass with "contains 1 value(s)"

		When I run `dab group start sidehustle`

		Then it should pass with:
		"""
		Executing five entrypoint start
		"""
		And the output should contain "cyberchef is available at http://localhost:"

	Scenario: Can group repositories and services then start them together
		Given I successfully run `dab services stop`
		And I successfully run `dab repo add six https://github.com/Nekroze/dotfiles.git`
		And I successfully run `dab group repos hackathon-2018 six`

		When I run `dab group services hackathon-2018 redis`

		Then it should pass with "contains 1 value(s)"

		When I run `dab group start hackathon-2018`

		Then it should pass with:
		"""
		Executing six entrypoint start
		"""
		And I successfully run `docker top services_redis_1`

	Scenario: Can group groups and repos then start them together
		Given I successfully run `dab services stop`
		And I successfully run `dab repo add seven https://github.com/Nekroze/dotfiles.git`
		And I successfully run `dab group repos subset seven`
		And I successfully run `dab group services superset redis`

		When I run `dab group groups superset subset`

		Then it should pass with "contains 1 value(s)"

		When I run `dab group start superset`

		Then it should pass with:
		"""
		Executing seven entrypoint start
		"""
		And I successfully run `docker top services_redis_1`