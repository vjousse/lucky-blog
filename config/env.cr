# Environments are managed using `LuckyEnv`. By default, development, production
# and test are supported.

# If you need additional environment support, add it here
# LuckyEnv.add_env :staging

module LuckyEnv
  extend self

  {% for env in [:development, :test, :production] %}
    def {{ env.id }}?
      name == {{ env.id.stringify }}
    end
  {% end %}

  def name
    ENV["LUCKY_ENV"]? || "development"
  end
end
