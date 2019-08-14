
import AVFoundation

extension AudioBuffer {
    func array() -> [Float] {
        return Array(UnsafeBufferPointer(self))
    }
}

extension AVAudioPCMBuffer {
    func array() -> [Float] {
        return self.audioBufferList.pointee.mBuffers.array()
    }
}

extension Array where Element: FloatingPoint {
    mutating func buffer() -> AudioBuffer {
        return AudioBuffer(mNumberChannels: 1, mDataByteSize: UInt32(self.count * MemoryLayout<Element>.size), mData: &self)
    }
}
