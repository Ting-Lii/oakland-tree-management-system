package Model;

public class TreeSpecies {
    private String commonName;
    private String scientificName;
    private int minHeight;
    private int maxHeight;
    private int minWidth;
    private int maxWidth;
    private Integer minPlantingBedWidth;
    private Boolean isPlantableUnderPowerLines;
    private Boolean isCaNative;
    private String droughtTolerance;
    private String growthRate;
    private String foliageType;
    private String debris;
    private String rootDamagePotential;
    private String nurseryAvailability;
    private String visualAttraction;
    private int inventory;

    public TreeSpecies(String commonName, String scientificName, int minHeight, int maxHeight, int minWidth,
            int maxWidth, Integer minPlantingBedWidth, Boolean isPlantableUnderPowerLines, Boolean isCaNative,
            String droughtTolerance, String growthRate, String foliageType, String debris,
            String rootDamagePotential, String nurseryAvailability, String visualAttraction, int inventory) {
        this.commonName = commonName;
        this.scientificName = scientificName;
        this.minHeight = minHeight;
        this.maxHeight = maxHeight;
        this.minWidth = minWidth;
        this.maxWidth = maxWidth;
        this.minPlantingBedWidth = minPlantingBedWidth;
        this.isPlantableUnderPowerLines = isPlantableUnderPowerLines;
        this.isCaNative = isCaNative;
        this.droughtTolerance = droughtTolerance;
        this.growthRate = growthRate;
        this.foliageType = foliageType;
        this.debris = debris;
        this.rootDamagePotential = rootDamagePotential;
        this.nurseryAvailability = nurseryAvailability;
        this.visualAttraction = visualAttraction;
        this.inventory = inventory;
    }

    public String getCommonName() {
        return commonName;
    }
    public void setCommonName(String commonName) {
        this.commonName = commonName;
    }
    public String getScientificName() {
        return scientificName;
    }
    public void setScientificName(String scientificName) {
        this.scientificName = scientificName;
    }
    public int getMinHeight() {
        return minHeight;
    }
    public void setMinHeight(int minHeight) {
        this.minHeight = minHeight;
    }
    public int getMaxHeight() {
        return maxHeight;
    }
    public void setMaxHeight(int maxHeight) {
        this.maxHeight = maxHeight;
    }
    public int getMinWidth() {
        return minWidth;
    }
    public void setMinWidth(int minWidth) {
        this.minWidth = minWidth;
    }
    public int getMaxWidth() {
        return maxWidth;
    }
    public void setMaxWidth(int maxWidth) {
        this.maxWidth = maxWidth;
    }
    public Integer getMinPlantingBedWidth() {
        return minPlantingBedWidth;
    }
    public void setMinPlantingBedWidth(Integer minPlantingBedWidth) {
        this.minPlantingBedWidth = minPlantingBedWidth;
    }
    public Boolean getIsPlantableUnderPowerLines() {
        return isPlantableUnderPowerLines;
    }
    public void setIsPlantableUnderPowerLines(Boolean isPlantableUnderPowerLines) {
        this.isPlantableUnderPowerLines = isPlantableUnderPowerLines;
    }
    public Boolean getIsCaNative() {
        return isCaNative;
    }
    public void setIsCaNative(Boolean isCaNative) {
        this.isCaNative = isCaNative;
    }
    public String getDroughtTolerance() {
        return droughtTolerance;
    }
    public void setDroughtTolerance(String droughtTolerance) {
        this.droughtTolerance = droughtTolerance;
    }
    public String getGrowthRate() {
        return growthRate;
    }
    public void setGrowthRate(String growthRate) {
        this.growthRate = growthRate;
    }
    public String getFoliageType() {
        return foliageType;
    }
    public void setFoliageType(String foliageType) {
        this.foliageType = foliageType;
    }
    public String getDebris() {
        return debris;
    }
    public void setDebris(String debris) {
        this.debris = debris;
    }
    public String getRootDamagePotential() {
        return rootDamagePotential;
    }
    public void setRootDamagePotential(String rootDamagePotential) {
        this.rootDamagePotential = rootDamagePotential;
    }
    public String getNurseryAvailability() {
        return nurseryAvailability;
    }
    public void setNurseryAvailability(String nurseryAvailability) {
        this.nurseryAvailability = nurseryAvailability;
    }
    public String getVisualAttraction() {
        return visualAttraction;
    }


    public void setVisualAttraction(String visualAttraction) {
        this.visualAttraction = visualAttraction;
    }
    public int getInventory() {
        return inventory;
    }
    // add or subtract inventory
    public void addInventory(int treeNum) {
        this.inventory = inventory + treeNum;
    }

    public void subtractInventory(int treeNum) {
        this.inventory = inventory - treeNum;
    }

}
