# https://stackoverflow.com/questions/24072790/how-to-detect-key-presses
# https://stackoverflow.com/questions/45100234/change-mouse-pointer-speed-in-windows-using-python
import ctypes
import keyboard


class Tbsp:

    def __init__(self, **kws):
        self.normal_speed = self.get_speed()
        self.slow_speed = kws.get('slow_speed', 3)
        self.dup = 2
        self.ddown = 4

    @staticmethod
    def get_speed():
        get_mouse_speed = 112   # 0x0070 for SPI_GETMOUSESPEED
        speed = ctypes.c_int()
        ctypes.windll.user32.SystemParametersInfoA(get_mouse_speed, 0, ctypes.byref(speed), 0)
        return speed.value

    @staticmethod
    def set_speed(speed):
        set_mouse_speed = 113   # 0x0071 for SPI_SETMOUSESPEED
        ctypes.windll.user32.SystemParametersInfoA(set_mouse_speed, 0, speed, 0)

    def set_speed_normal(self):
        self.set_speed(self.normal_speed)

    def set_speed_slow(self):
        self.set_speed(self.normal_speed - self.ddown)

    def set_speed_fast(self):
        self.set_speed(self.normal_speed + self.dup)

    def control_speed(self):
        while True:
            if keyboard.is_pressed('ctrl'):
                self.set_speed_slow()
            elif keyboard.is_pressed('shift'):
                self.set_speed_fast()
            else:   
                self.set_speed_normal()


def main():
    ctrlr = Tbsp(slow_speed=4)
    try:
        ctrlr.control_speed()
    except:
        ctrlr.set_speed_normal()


if __name__ == '__main__':
    main()