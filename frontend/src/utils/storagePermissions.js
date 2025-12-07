/**
 * Storage Permissions Utility
 * Request persistent storage and check quota
 */

class StoragePermissions {
    constructor() {
        this.hasRequestedPersistent = false;
    }

    /**
     * Request persistent storage on first run
     * Prevents browser from auto-evicting cached data
     */
    async requestPersistentStorage() {
        if (this.hasRequestedPersistent) {
            return true;
        }

        if (!navigator.storage || !navigator.storage.persist) {
            console.warn('Persistent storage API not supported');
            return false;
        }

        try {
            // Check if already persistent
            const isPersisted = await navigator.storage.persisted();
            if (isPersisted) {
                console.log('✅ Storage is already persistent');
                this.hasRequestedPersistent = true;
                return true;
            }

            // Request persistent storage
            const granted = await navigator.storage.persist();
            this.hasRequestedPersistent = true;

            if (granted) {
                console.log('✅ Persistent storage granted');
                return true;
            } else {
                console.warn('⚠️ Persistent storage denied - data may be evicted');
                return false;
            }
        } catch (error) {
            console.error('Error requesting persistent storage:', error);
            return false;
        }
    }

    /**
     * Check storage quota and usage
     * @returns {Promise<Object>}
     */
    async checkQuota() {
        if (!navigator.storage || !navigator.storage.estimate) {
            return {
                available: 'unknown',
                used: 'unknown',
                percentUsed: 'unknown'
            };
        }

        try {
            const estimate = await navigator.storage.estimate();
            const usedMB = (estimate.usage / (1024 * 1024)).toFixed(2);
            const availableMB = (estimate.quota / (1024 * 1024)).toFixed(2);
            const percentUsed = ((estimate.usage / estimate.quota) * 100).toFixed(1);

            return {
                used: `${usedMB} MB`,
                available: `${availableMB} MB`,
                percentUsed: `${percentUsed}%`,
                usedBytes: estimate.usage,
                quotaBytes: estimate.quota
            };
        } catch (error) {
            console.error('Error checking storage quota:', error);
            return {
                available: 'unknown',
                used: 'unknown',
                percentUsed: 'unknown'
            };
        }
    }

    /**
     * Check if storage is running low (> 80% used)
     * @returns {Promise<boolean>}
     */
    async isStorageLow() {
        const quota = await this.checkQuota();
        if (quota.percentUsed === 'unknown') {
            return false;
        }

        const percent = parseFloat(quota.percentUsed);
        return percent > 80;
    }

    /**
     * Show storage warning if running low
     */
    async showStorageWarningIfNeeded() {
        const isLow = await this.isStorageLow();
        if (isLow) {
            const quota = await this.checkQuota();
            console.warn(`⚠️ Storage running low: ${quota.percentUsed} used`);
            return true;
        }
        return false;
    }
}

export default new StoragePermissions();
