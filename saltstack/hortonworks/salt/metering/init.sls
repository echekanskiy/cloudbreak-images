{% set os = salt['environ.get']('OS') %}
{% set major_version = '1' %}
{% set minor_version = '0' %}
{% set artifact_repo = '0' %}

{% if grains['init'] == 'systemd' %}
  {% if os.startswith("centos") or os.startswith("redhat") or os == "amazonlinux2" %}
  install_metering_heartbeat_rpm:
    cmd.run:
      - names:
        - yum install -y https://mastodon-systest.s3-us-west-2.amazonaws.com/metering-heartbeat-producer-1-0.x86_64.rpm
  {% elif os.startswith("ubuntu") or os.startswith("debian") %}
  install_metering_heartbeat_deb:
    cmd.run:
      - name: echo "Warning - Metering client is not supported (yet) for this OS type ({{ os }})"
  {% else %}
  warning_metering_heartbeat_os:
    cmd.run:
      - name: echo "Warning - Metering client is not supported for this OS type ({{ os }})"
  {% endif %}
{% else %}
  warning_metering_heartbeat_systemd:
    cmd.run:
      - name: echo "Warning - Metering client requires systemd which is not installed"
{% endif %}