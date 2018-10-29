
-- return cfg

local cfg = {}

cfg.firstjob = "Civil" -- set this to your first job, for example "citizen", or false to disable

-- text display css
cfg.display_css = [[
@font-face {
  font-family: 'hyperion';
  src: url('https://byhyperion.net/stylesheet/fonts/american_captain.ttf');
}
.div_job{
  position: absolute;
  top: 30px;
  left: 40px;
  letter-spacing: 1.5px;
  font-size: 29px;
  font-weight: bold;
  color: white;
  text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000, 1px 1px 0 #000;
  font-family: "hyperion";
}
]]

-- icon display css
cfg.icon_display_css = [[
.div_job_icon{
  position: absolute;
  height: 33px;
  width: 33px;
  bottom: 2px;
  left: 304px;
}
]]

-- list of ["group"] => css for icons
cfg.group_icons = {
  ["Betjent"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/betjent.png);
    }
  ]],
  ["Elev"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/betjent.png);
    }
  ]],
  ["AKS"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/aks.png);
    }
  ]],
  ["Ambulanceredder"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/ambulanceredder.png);
    }
  ]],
  ["Mekaniker"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/mekaniker.png);
    }
  ]],
  ["Taxa"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/taxa.png);
    }
  ]],
  ["Træhugger"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/traehugger.png);
    }
  ]],
  ["Advokat"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/advokat.png);
    }
  ]],
  ["Dommer"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/dommer.png);
    }
  ]],
  ["Civil"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/civil.png);
    }
  ]],
  ["Udbringer"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/udbringer.png);
    }
  ]],
  ["Postbud"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/postbud.png);
    }
  ]],
  ["Skraldemand"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/skraldemand.png);
    }
  ]],
  ["Lastbilchauffør"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/lastbilchauffor.png);
    }
  ]],
  ["Pengetransport"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/pengetransporter.png);
    }
  ]],
  ["Minearbejder"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/minearbejder.png);
    }
  ]],
  ["PET-agent"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/civil.png);
    }
  ]],
  ["Psykolog"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/psych.png);
    }
  ]],
  ["Fisker"] = [[
    .div_job_icon{
      content: url(https://lassemc.dk/hyp/jobs/fisker.png);
    }
  ]],
  ["Journalist"] = [[
    .div_job_icon{
      content: url(http://second.terstedmikkelsen.dk/hyp/jobs/newspaper.png);
    }
  ]], -- this is an example, add more under it using the same model, leave the } at the end.
}
return cfg