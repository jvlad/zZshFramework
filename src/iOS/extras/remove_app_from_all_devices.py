#!/usr/bin/env python3

import sys
from isim import Runtime, Device
from typing import List


def main():
    if len(sys.argv) < 2:
        print(f"Error: App BundleID isn't specified. Aborting...")
        return
    
    for simulator in booted_simulators():
        for app_to_uninstall in sys.argv[1:]:
            simulator.uninstall(app_to_uninstall)


def booted_simulators() -> List[Device]:
    booted_simulators: List[Device] = []
    for devices_list in Device.list_all().values():
        [booted_simulators.append(device) for device in devices_list
            if device.state == "Booted"]
    return booted_simulators


if __name__ == "__main__":
    main()
