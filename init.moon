
lfe_mode_reg =
  name: 'lfe'
  extensions: { 'lfe' }
  create: -> bundle_load('lfe_mode')!

howl.mode.register lfe_mode_reg

unload = ->
  howl.mode.unregister 'lfe'

return {
  info:
    author: 'Rok Fajfar'
    description: 'LFE mode'
    license: 'MIT'
  :unload
}
