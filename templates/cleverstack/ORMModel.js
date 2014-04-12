module.exports = function( sequelize, DataTypes ) {
    return sequelize.define("MODEL_NAME", {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        name: {
            type: DataTypes.STRING,
            allowNull: false,
            unique: true
        }
    });
};
