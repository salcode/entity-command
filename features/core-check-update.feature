Feature: Check for more recent versions

  Scenario: Check for update via Version Check API
    Given a WP install

    When I run `wp core download --version=3.8 --force`
    Then STDOUT should not be empty

    When I run `wp core check-update`
    Then STDOUT should be a table containing rows:
      | version | update_type | package_url                                |
      | 4.4     | major       | https://wordpress.org/wordpress-4.4.zip    |
      | 3.8.11  | minor       | https://wordpress.org/wordpress-3.8.11.zip |

    When I run `wp core check-update --format=count`
    Then STDOUT should be:
      """
      2
      """

    When I run `wp core check-update --major`
    Then STDOUT should be a table containing rows:
      | version | update_type | package_url                                |
      | 4.4     | major       | https://wordpress.org/wordpress-4.4.zip    |

    When I run `wp core check-update --major --format=count`
    Then STDOUT should be:
      """
      1
      """

    When I run `wp core check-update --minor`
    Then STDOUT should be a table containing rows:
      | version | update_type | package_url                                |
      | 3.8.11  | minor       | https://wordpress.org/wordpress-3.8.11.zip |

    When I run `wp core check-update --minor --format=count`
    Then STDOUT should be:
      """
      1
      """