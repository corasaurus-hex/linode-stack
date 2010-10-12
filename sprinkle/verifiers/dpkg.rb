module Sprinkle
  module Verifiers
    module Dpkg
      Sprinkle::Verify.register(Sprinkle::Verifiers::Dpkg)

      def has_dpkg(*packages)
        options = if packages[packages.size - 1].is_a?(Hash)
          packages.pop
        else
          {}
        end

        commands = packages.map do |package|
          command = %@[ -n "`dpkg-query -W -f '${Version}' #{package}@
          if options[:version]
            command << %@ | grep '#{options[:version]}'@
          end
          command << %@`" ]@
        end.join(' && ')

        @commands << commands
      end

      alias :has_dpkgs :has_dpkg
    end
  end
end
