class Configure:
    def __init__(self):
        self.store = {}

    def __getattr__(self, name):
        return None

    def __setattr__(self, name, value):
        if name in self.__dict__.keys():
            return setattr(self.store, name, value)
        else:
            return super().__setattr__(name, value)
