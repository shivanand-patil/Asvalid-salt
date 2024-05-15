# /srv/salt/asvalid.sls

# Define a state to ensure the directory /home/ubuntu/Asvalid-tool exists
ensure_tool_directory_exists:
  file.directory:
    - name: /home/ubuntu/Asvalid-tool
    - makedirs: True

# Define a state to check if the tool is already installed
check_tool_installed:
  cmd.run:
    - name: '[ -x /usr/local/bin/asvalid-tool ] && echo "Tool is already installed" || echo "Tool is not installed"'
    - onlyif: '[ -x /usr/local/bin/asvalid-tool ]'
    - unless: '[ ! -x /usr/local/bin/asvalid-tool ]'
    - require:
      - file: ensure_tool_directory_exists

# Define a state to copy the project directory and its contents to the minion's home directory
copy_project_to_minions_home:
  file.recurse:
    - name: /home/ubuntu/Asvalid-tool/
    - source: salt://Asvalid-tool/
    - include_empty: True
    - require:
      - file: ensure_tool_directory_exists

# Define a state to set executable permissions for install.sh
set_install_script_permissions:
  file.managed:
    - name: /home/ubuntu/Asvalid-tool/install.sh
    - mode: '755'  # Set mode to '755' to make the script executable
    - require:
      - file: copy_project_to_minions_home

# Define a state to execute the install script on minions
install_project_tool:
  cmd.run:
    - name: |
        cd /home/ubuntu/Asvalid-tool/
        ./install.sh
    - cwd: /home/ubuntu/Asvalid-tool/
    - require:
      - file: set_install_script_permissions
