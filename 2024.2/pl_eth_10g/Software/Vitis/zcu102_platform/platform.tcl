# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/elya/Public/ZCU102-Ethernet-main/2024.2/pl_eth_10g/Software/Vitis/zcu102_platform/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/elya/Public/ZCU102-Ethernet-main/2024.2/pl_eth_10g/Software/Vitis/zcu102_platform/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {zcu102_platform}\
-hw {/home/elya/Public/ZCU102-Ethernet-main/2024.2/pl_eth_10g/Hardware/pre-built/pl_eth_10g_wrapper.xsa}\
-proc {psu_cortexa53} -os {linux} -arch {64-bit} -fsbl-target {psu_cortexa53_0} -out {/home/elya/Public/ZCU102-Ethernet-main/2024.2/pl_eth_10g/Software/Vitis}

platform write
platform active {zcu102_platform}
platform config -remove-boot-bsp
platform write
platform config -fsbl-elf {/home/elya/Public/ZCU102-Ethernet-main/2024.2/pl_eth_10g/Software/PetaLinux/images/linux/zynqmp_fsbl.elf}
platform write
platform config -pmufw-elf {/home/elya/Public/ZCU102-Ethernet-main/2024.2/pl_eth_10g/Software/PetaLinux/images/linux/pmufw.elf}
platform write
platform active {zcu102_platform}
