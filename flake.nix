{
	description = "Tools for debloating and installing Google Play Services on Fire Tablets + More!";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	};

	outputs = { self, nixpkgs }: let

	supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
	forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

	pythonDependencies = (python-pkgs: with python-pkgs; [
		certifi
		charset-normalizer
		customtkinter
		darkdetect
		packaging
		requests
		tkinter
		urllib3
	]);

	in {
		devShells = forAllSystems (system: let
			pkgs = nixpkgs.legacyPackages.${system};
			pythonWithDeps = pythonDependencies pkgs.python311Packages;
		in {
			default = pkgs.mkShellNoCC {
				packages = with pkgs; [ android-tools pythonWithDeps ];
			};
		});

		apps = forAllSystems (system: {
			default = {
				type = "app";
				program = "${self.packages.${system}.fire-tools}/bin/fire-tools";
			};
		});

		packages = forAllSystems (system: let
			pkgs = nixpkgs.legacyPackages.${system};
			pythonWithDeps = pkgs.python3.withPackages pythonDependencies;
		in {
			default = self.packages.${system}.fire-tools;

			fire-tools = pkgs.stdenv.mkDerivation {
				pname = "Fire-Tools";
				version = builtins.readFile ./Fire-Tools/version;
				src = ./Fire-Tools;

				propogatedBuildInputs = with pkgs; [ android-tools pythonWithDeps ];

				buildPhase = "";
				installPhase = ''
					# Copy source files
					mkdir -p $out/src
					cp -R * $out/src

					# Create bin dir
					mkdir -p $out/bin

					# Create shell script to execute python script
					echo '#!/bin/sh' > $out/bin/fire-tools
					echo "exec ${pythonWithDeps.interpreter} $out/src/main.py \$@" >> $out/bin/fire-tools

					# Make bin and scripts executable
					find $out/src -type f -name '*.sh' -exec chmod +x {} \;
					chmod +x $out/bin/fire-tools
				'';

				meta = with pkgs.lib; {
					homepage = "https://github.com/mrhaydendp/Fire-Tools";
					license = licenses.mit;
					platforms = supportedSystems;
					maintainers = [ "mrhaydendp" ];
				};
			};
		});
	};
}
