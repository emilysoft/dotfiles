{pkgs, ...}: {
  systemd.user.services = {
    rutina-manana = {
      Unit = {Description = "Inicia mi día con Fish";};
      Service = {
        ExecStart = "${pkgs.fish}/bin/fish -lc 'gestor_horario abrir'";
      };
    };

    rutina-tarde = {
      Unit = {Description = "Cierra mi día con Fish";};
      Service = {
        ExecStart = "${pkgs.fish}/bin/fish -lc 'gestor_horario cerrar'";
      };
    };
  };

  systemd.user.timers = {
    timer-manana = {
      Unit = {Description = "Timer matutino 7am";};
      Timer = {
        Unit = "rutina-manana.service";
        OnCalendar = "*-*-* 07:00:00";
        Persistent = true;
      };
      Install = {WantedBy = ["timers.target"];};
    };

    timer-tarde = {
      Unit = {Description = "Timer vespertino 6pm";};
      Timer = {
        Unit = "rutina-tarde.service";
        OnCalendar = "*-*-* 18:00:00";
        Persistent = true;
      };
      Install = {WantedBy = ["timers.target"];};
    };
  };
}
