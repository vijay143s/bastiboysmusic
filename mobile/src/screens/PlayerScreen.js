import React from 'react';
import {
    View,
    Text,
    StyleSheet,
    Image,
    TouchableOpacity,
    Dimensions,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import Slider from '@react-native-community/slider';
import { LinearGradient } from 'expo-linear-gradient';
import { SongData } from '../context/Song';
import { COLORS, SIZES } from '../constants';

const { width } = Dimensions.get('window');

const PlayerScreen = ({ navigation }) => {
    const {
        song,
        isPlaying,
        currentPosition,
        duration,
        togglePlayPause,
        nextMusic,
        previousMusic,
        seekTo,
        addToQueue,
    } = SongData();

    const formatTime = (millis) => {
        if (!millis) return '0:00';
        const totalSeconds = Math.floor(millis / 1000);
        const minutes = Math.floor(totalSeconds / 60);
        const seconds = totalSeconds % 60;
        return `${minutes}:${seconds.toString().padStart(2, '0')}`;
    };

    const progress = duration > 0 ? currentPosition / duration : 0;

    return (
        <SafeAreaView style={styles.container} edges={['top']}>
            <LinearGradient
                colors={[COLORS.secondary, COLORS.background, COLORS.background]}
                style={styles.gradient}
            >
                {/* Header */}
                <View style={styles.header}>
                    <TouchableOpacity onPress={() => navigation.goBack()}>
                        <Ionicons name="chevron-down" size={28} color={COLORS.text} />
                    </TouchableOpacity>
                    <Text style={styles.headerTitle}>Now Playing</Text>
                    <TouchableOpacity onPress={() => navigation.navigate('Queue')}>
                        <Ionicons name="list" size={24} color={COLORS.text} />
                    </TouchableOpacity>
                </View>

                {/* Album Art */}
                <View style={styles.artworkContainer}>
                    <Image
                        source={{ uri: song?.thumbnail?.url || 'https://via.placeholder.com/300' }}
                        style={styles.artwork}
                    />
                </View>

                {/* Song Info */}
                <View style={styles.infoContainer}>
                    <Text style={styles.title} numberOfLines={1}>
                        {song?.title || 'No Song Playing'}
                    </Text>
                    <Text style={styles.artist} numberOfLines={1}>
                        {song?.singer || 'Unknown Artist'}
                    </Text>
                </View>

                {/* Progress Bar */}
                <View style={styles.progressContainer}>
                    <Slider
                        style={styles.slider}
                        minimumValue={0}
                        maximumValue={duration}
                        value={currentPosition}
                        onSlidingComplete={seekTo}
                        minimumTrackTintColor={COLORS.primary}
                        maximumTrackTintColor={COLORS.border}
                        thumbTintColor={COLORS.primary}
                    />
                    <View style={styles.timeContainer}>
                        <Text style={styles.time}>{formatTime(currentPosition)}</Text>
                        <Text style={styles.time}>{formatTime(duration)}</Text>
                    </View>
                </View>

                {/* Controls */}
                <View style={styles.controls}>
                    <TouchableOpacity onPress={() => addToQueue(song)}>
                        <Ionicons name="add-circle-outline" size={32} color={COLORS.text} />
                    </TouchableOpacity>

                    <TouchableOpacity onPress={previousMusic}>
                        <Ionicons name="play-skip-back" size={40} color={COLORS.text} />
                    </TouchableOpacity>

                    <TouchableOpacity style={styles.playButton} onPress={togglePlayPause}>
                        <Ionicons
                            name={isPlaying ? 'pause' : 'play'}
                            size={40}
                            color={COLORS.background}
                        />
                    </TouchableOpacity>

                    <TouchableOpacity onPress={() => nextMusic('manual')}>
                        <Ionicons name="play-skip-forward" size={40} color={COLORS.text} />
                    </TouchableOpacity>

                    <TouchableOpacity>
                        <Ionicons name="heart-outline" size={32} color={COLORS.text} />
                    </TouchableOpacity>
                </View>
            </LinearGradient>
        </SafeAreaView>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: COLORS.background,
    },
    gradient: {
        flex: 1,
    },
    header: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        paddingHorizontal: SIZES.padding,
        paddingVertical: SIZES.padding,
    },
    headerTitle: {
        fontSize: 16,
        fontWeight: '600',
        color: COLORS.text,
    },
    artworkContainer: {
        alignItems: 'center',
        marginTop: 40,
        marginBottom: 40,
    },
    artwork: {
        width: width - 80,
        height: width - 80,
        borderRadius: 12,
        backgroundColor: COLORS.card,
    },
    infoContainer: {
        paddingHorizontal: SIZES.padding * 2,
        marginBottom: 24,
    },
    title: {
        fontSize: 24,
        fontWeight: 'bold',
        color: COLORS.text,
        textAlign: 'center',
        marginBottom: 8,
    },
    artist: {
        fontSize: 16,
        color: COLORS.textSecondary,
        textAlign: 'center',
    },
    progressContainer: {
        paddingHorizontal: SIZES.padding * 2,
        marginBottom: 24,
    },
    slider: {
        width: '100%',
        height: 40,
    },
    timeContainer: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    time: {
        fontSize: 12,
        color: COLORS.textSecondary,
    },
    controls: {
        flexDirection: 'row',
        justifyContent: 'space-around',
        alignItems: 'center',
        paddingHorizontal: SIZES.padding * 2,
        marginBottom: 40,
    },
    playButton: {
        width: 70,
        height: 70,
        borderRadius: 35,
        backgroundColor: COLORS.primary,
        justifyContent: 'center',
        alignItems: 'center',
    },
});

export default PlayerScreen;
