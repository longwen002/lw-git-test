import common

# add for find the image exist or not
def HasTheImage(target_files_zip, partition):
  try:
    target_files_zip.getinfo("IMAGES/" + partition)
    return True
  except KeyError:
    return False

def FullOTA_InstallBegin(info):
  if HasTheImage(info.input_zip, "fastboot.img"):
    common.ZipWriteStr(info.output_zip, "fastboot.img", info.input_zip.read("IMAGES/fastboot.img"))
  if HasTheImage(info.input_zip, "fbl.img"):
    common.ZipWriteStr(info.output_zip, "fbl.img", info.input_zip.read("IMAGES/fbl.img"))
  if HasTheImage(info.input_zip, "sbl.img"):
    common.ZipWriteStr(info.output_zip, "sbl.img", info.input_zip.read("IMAGES/sbl.img"))
  common.ZipWriteStr(info.output_zip, "bootargs.img", info.input_zip.read("IMAGES/bootargs.img"))
  common.ZipWriteStr(info.output_zip, "bootargsbak.img", info.input_zip.read("IMAGES/bootargsbak.img"))
  common.ZipWriteStr(info.output_zip, "recovery.img", info.input_zip.read("IMAGES/recovery.img"))
  common.ZipWriteStr(info.output_zip, "recoverybak.img", info.input_zip.read("IMAGES/recoverybak.img"))
  common.ZipWriteStr(info.output_zip, "bl31.img", info.input_zip.read("IMAGES/bl31.img"))
  common.ZipWriteStr(info.output_zip, "baseparam.img", info.input_zip.read("IMAGES/baseparam.img"))
  common.ZipWriteStr(info.output_zip, "dtbo.img", info.input_zip.read("IMAGES/dtbo.img"))
  common.ZipWriteStr(info.output_zip, "logo.img", info.input_zip.read("IMAGES/logo.img"))
  common.ZipWriteStr(info.output_zip, "pqparam.img", info.input_zip.read("IMAGES/pqparam.img"))
  if HasTheImage(info.input_zip, "trustedcore.img"):
    common.ZipWriteStr(info.output_zip, "trustedcore.img", info.input_zip.read("IMAGES/trustedcore.img"))
  if HasTheImage(info.input_zip, "securestore.img"):
    common.ZipWriteStr(info.output_zip, "securestore.img", info.input_zip.read("IMAGES/securestore.img"))
  common.ZipWriteStr(info.output_zip, "cache.img", info.input_zip.read("IMAGES/cache.img"))
  common.ZipWriteStr(info.output_zip, "userdata.img", info.input_zip.read("IMAGES/userdata.img"))

  info.script.AppendExtra("open_led();")
  info.script.AppendExtra(('if (get_stage("%s") == "" ) then' ) % ("/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/misc"))
  info.script.Print("update recovery... stage: 1/2......")
  info.script.Print("update recoverybak and bootargsbak......")
  info.script.AppendExtra(('if (get_recovery_state("%s") != "b" ) then' ) % ("/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/misc"))
  info.script.Print("update recoverybak...")
  info.script.WriteRawImage("/recoverybak", "recoverybak.img")
  info.script.Print("update bootargsbak...")
  info.script.WriteRawImage("/bootargsbak", "bootargsbak.img")
  info.script.AppendExtra('set_recovery_state("%s", "%s");' % ("/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/misc", "b"))
  info.script.AppendExtra('endif;')
  info.script.Print("update recovery(not bak)......")
  info.script.Print("update recovery...")
  info.script.WriteRawImage("/recovery", "recovery.img")
  info.script.Print("update bootargs...")
  info.script.WriteRawImage("/bootargs", "bootargs.img")
  info.script.AppendExtra('set_recovery_state("%s", "%s");' % ("/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/misc", "a"))
  info.script.AppendExtra('set_stage("%s", "%s");' % ("/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/misc", "2/2"))
  info.script.AppendExtra('endif;')

  info.script.AppendExtra(('if (get_stage("%s") == "2/2" ) then' ) % ("/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/misc"))
  info.script.Print("update recovery...stage 2/2......");
  if HasTheImage(info.input_zip, "fastboot.img"):
    info.script.Print("update fastboot...")
    info.script.WriteRawImage("/fastboot", "fastboot.img")
  if HasTheImage(info.input_zip, "fbl.img"):
    info.script.Print("update fbl...")
    info.script.WriteRawImage("/fbl", "fbl.img")
  if HasTheImage(info.input_zip, "sbl.img"):
    info.script.Print("update sbl...")
    info.script.WriteRawImage("/sbl", "sbl.img")
  info.script.Print("update atf...")
  info.script.WriteRawImage("/atf", "bl31.img")
  #info.script.Print("update baseparam...")
  #info.script.WriteRawImage("/baseparam", "baseparam.img")
  info.script.Print("update logo...")
  info.script.WriteRawImage("/logo", "logo.img")
  info.script.Print("update pqparam...")
  info.script.WriteRawImage("/pqparam", "pqparam.img")
  info.script.Print("update trustedcore...")
  info.script.WriteRawImage("/trustedcore", "trustedcore.img")
  info.script.Print("update dtbo...")
  info.script.WriteRawImage("/dtbo", "dtbo.img")
  #info.script.Print("update securestore......")
  #info.script.AppendExtra('format("%s", "%s", "%s", "%s", "%s");' % ("ext4", "EMMC", "/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/securestore", "0", "/securestore"))
  #info.script.AppendExtra('package_extract_file("%s", "%s");' % ("securestore.img", "/tmp/securestore.ext4"))
  #info.script.AppendExtra('write_ext4sp_img("%s", "%s");' % ("/tmp/securestore.ext4", "/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/securestore"))
  #info.script.AppendExtra('delete("%s");' % ("/tmp/securestore.ext4"))
  #info.script.Print("update cache......")
  #info.script.AppendExtra(('if (is_mounted("%s") == "" ) then' ) % ("/cache"))
  #info.script.AppendExtra('format("%s", "%s", "%s", "%s", "%s");' % ("ext4", "EMMC", "/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/cache", "0", "/cache"))
  #info.script.AppendExtra('package_extract_file("%s", "%s");' % ("cache.img", "/tmp/cache.ext4"))
  #info.script.AppendExtra('write_ext4sp_img("%s", "%s");' % ("/tmp/cache.ext4", "/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/cache"))
  #info.script.AppendExtra('delete("%s");' % ("/tmp/cache.ext4"))
  #info.script.Print("remount cache......")
  #info.script.AppendExtra('mount("%s", "%s", "%s", "%s");' % ("ext4", "EMMC", "/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/cache", "/cache"))
  #info.script.Print("create /cache/recovery/......")
  #info.script.AppendExtra('create_empty_dir("%s");' % ("/cache/recovery/"))
  #info.script.AppendExtra('endif;')
  #info.script.Print("update userdata......")
  #info.script.AppendExtra('format("%s", "%s", "%s", "%s", "%s");' % ("ext4", "EMMC", "/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/userdata", "0", "/data"))
  #info.script.AppendExtra('package_extract_file("%s", "%s");' % ("userdata.img", "/tmp/userdata.ext4"))
  #info.script.AppendExtra('write_ext4sp_img("%s", "%s");' % ("/tmp/userdata.ext4", "/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/userdata"))
  #info.script.AppendExtra('delete("%s");' % ("/tmp/userdata.ext4"))
  info.script.AppendExtra('endif;')

def GetSrcAndTagBootableImage(info, image_full_name):
  source = common.GetBootableImage(
      "/tmp/" + image_full_name, image_full_name, common.OPTIONS.source_tmp, "IMAGES", info.info_dict)
  target = common.GetBootableImage(
      "/tmp/" + image_full_name, image_full_name, common.OPTIONS.target_tmp, "IMAGES", info.info_dict)
  return (source, target)

def CheckUpdatingImage(info, image, suffix):
  image_full_name = image + suffix
  source, target = GetSrcAndTagBootableImage(info, image_full_name)
  if source != target:
    type, device = common.GetTypeAndDevice(
        "/" + image, info.info_dict)
    d = common.Difference(target, source)
    _, _, d = d.ComputePatch()
    if d is None:
      print("%s do not change, no need to update" % (image,))
    else:
      print("%s target: %d  source: %d  diff: %d" % (image,
          target.size, source.size, len(d)))
      info.script.CacheFreeSpaceCheck(source.size)
      common.ZipWriteStr(info.output_zip, "patch/" + image_full_name + ".p", d)

      info.script.PatchCheck("%s:%s:%d:%s:%d:%s" %
                        (type, device,
                         source.size, source.sha1,
                         target.size, target.sha1))

def HiAddFullImage(info, device, image, suffix):
  image_full_name = image + suffix
  source, target = GetSrcAndTagBootableImage(info, image_full_name)

  common.ZipWriteStr(info.output_zip, image_full_name, target.data)
  info.script.WriteRawImage(device, image_full_name)

#def IncrementalOTA_VerifyBegin(info):
#  if HasTheImage(info.target_zip, "fastboot.img"):
#    CheckUpdatingImage(info, "fastboot",".img")
#  if HasTheImage(info.target_zip, "fbl.img"):
#    CheckUpdatingImage(info, "fbl",".img")
#  if HasTheImage(info.target_zip, "sbl.img"):
#    CheckUpdatingImage(info, "sbl",".img")
#  CheckUpdatingImage(info, "bootargs",".img")
#  CheckUpdatingImage(info, "bootargsbak",".img")
#  CheckUpdatingImage(info, "recovery",".img")
#  CheckUpdatingImage(info, "recoverybak",".img")
#  CheckUpdatingImage(info, "dtbo",".img")
#  CheckUpdatingImage(info, "logo",".img")

def ImageNameAmend(image):
  if image == "tcon" or image == "panel":
    image = image + "param"
  return image;

def IncrementalUpdatingImage(info, image, suffix):
  image_full_name = image + suffix
  source, target = GetSrcAndTagBootableImage(info, image_full_name)
  if source.data != target.data:
    print("%s image changed; including patch." % (image,))
    type, device = common.GetTypeAndDevice(
        "/" + ImageNameAmend(image), info.info_dict)
    info.script.ApplyPatch("%s:%s:%d:%s:%d:%s"
                    % (type, device,
                       source.size, source.sha1,
                       target.size, target.sha1),
                    "-",
                    target.size, target.sha1,
                    source.sha1, "patch/" + image_full_name + ".p")

def IncrementalOTA_InstallBegin(info):
  info.script.AppendExtra(('if (get_stage("%s") == "" ) then' ) % ("/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/misc"))
  info.script.Print("update recovery... stage: 1/2......")
  info.script.Print("update recoverybak and bootargsbak......")
  info.script.AppendExtra(('if (get_recovery_state("%s") != "b" ) then' ) % ("/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/misc"))
  info.script.Print("update recoverybak...")
  HiAddFullImage(info, "/recoverybak", "recoverybak", ".img")
  info.script.Print("update bootargsbak...")
  HiAddFullImage(info, "/bootargsbak", "bootargsbak", ".img")
  info.script.AppendExtra('set_recovery_state("%s", "%s");' % ("/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/misc", "b"))
  info.script.AppendExtra('endif;')
  info.script.Print("update recovery(not bak)......")
  info.script.Print("update recovery...")
  HiAddFullImage(info, "/recovery", "recovery", ".img")
  info.script.Print("update bootargs...")
  HiAddFullImage(info, "/bootargs", "bootargs", ".img")
  info.script.AppendExtra('set_recovery_state("%s", "%s");' % ("/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/misc", "a"))
  info.script.AppendExtra('set_stage("%s", "%s");' % ("/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/misc", "2/2"))
  info.script.AppendExtra('endif;')
  info.script.AppendExtra(('if (get_stage("%s") == "2/2" ) then' ) % ("/dev/block/platform/soc/f9830000.himciv200.MMC/by-name/misc"))
  info.script.Print("update recovery...stage 2/2......")
  if HasTheImage(info.target_zip, "fastboot.img"):
    info.script.Print("update fastboot...")
    HiAddFullImage(info, "/fastboot", "fastboot", ".img")
  if HasTheImage(info.target_zip, "fbl.img"):
    info.script.Print("update fbl...")
    HiAddFullImage(info, "/fbl", "fbl", ".img")
  if HasTheImage(info.target_zip, "sbl.img"):
    info.script.Print("update sbl...")
    HiAddFullImage(info, "/sbl", "sbl", ".img")
  HiAddFullImage(info, "/logo", "logo", ".img")
  HiAddFullImage(info, "/dtbo", "dtbo", ".img")
  if HasTheImage(info.target_zip, "trustedcore.img"):
    HiAddFullImage(info, "/trustedcore", "trustedcore", ".img")
  HiAddFullImage(info, "/atf", "bl31", ".img")
  HiAddFullImage(info, "/baseparam", "baseparam", ".img")
  HiAddFullImage(info, "/pqparam", "pqparam", ".img")
  info.script.AppendExtra('endif;')
